import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/manga.dart';
import '../providers/manga_provider.dart';

class AddEditMangaScreen extends StatefulWidget {
  final Manga? manga;

  const AddEditMangaScreen({super.key, this.manga});

  @override
  State<AddEditMangaScreen> createState() => _AddEditMangaScreenState();
}

class _AddEditMangaScreenState extends State<AddEditMangaScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _authorsController;
  late TextEditingController _ratingController;
  late TextEditingController _favoritesController;
  late TextEditingController _statusController;
  late TextEditingController _genresController;
  
  String? _coverPath;
  String? _chapterPath;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.manga?.title ?? '');
    _descriptionController = TextEditingController(text: widget.manga?.description ?? '');
    _authorsController = TextEditingController(text: widget.manga?.authors ?? '');
    _ratingController = TextEditingController(text: widget.manga?.rating ?? '');
    _favoritesController = TextEditingController(text: widget.manga?.favorites ?? '');
    _statusController = TextEditingController(text: widget.manga?.status ?? '');
    _genresController = TextEditingController(text: widget.manga?.genres.join(', ') ?? '');
    _coverPath = widget.manga?.coverPage;
    _chapterPath = widget.manga?.chapter;
    _isBookmarked = widget.manga?.isBookmarked ?? false;
  }

  Future<void> _pickCover() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _coverPath = pickedFile.path;
      });
    }
  }

  Future<void> _pickChapter() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _chapterPath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.manga != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Manga' : 'Add Manga', style: GoogleFonts.montserrat()),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickCover,
                child: Container(
                  height: 200,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(12),
                    image: _coverPath != null
                        ? (_coverPath!.startsWith('assets/') 
                            ? DecorationImage(image: AssetImage(_coverPath!), fit: BoxFit.cover)
                            : DecorationImage(image: FileImage(File(_coverPath!)), fit: BoxFit.cover))
                        : null,
                  ),
                  child: _coverPath == null
                      ? const Icon(Icons.add_a_photo, size: 40, color: Colors.white)
                      : null,
                ),
              ),
              const SizedBox(height: 10),
              Text('Tap to pick cover', style: GoogleFonts.karla(fontSize: 12)),
              const SizedBox(height: 20),
              _buildTextField(_titleController, 'Title'),
              _buildTextField(_descriptionController, 'Description', maxLines: 3),
              _buildTextField(_authorsController, 'Authors'),
              _buildTextField(_ratingController, 'Rating'),
              _buildTextField(_favoritesController, 'Favorites'),
              _buildTextField(_statusController, 'Status'),
              _buildTextField(_genresController, 'Genres (comma separated)'),
              const SizedBox(height: 20),
              ListTile(
                title: Text('Chapter (PDF)', style: GoogleFonts.montserrat()),
                subtitle: Text(_chapterPath ?? 'No file selected', style: GoogleFonts.karla()),
                trailing: IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: _pickChapter,
                ),
              ),
              SwitchListTile(
                title: Text('Bookmarked', style: GoogleFonts.montserrat()),
                value: _isBookmarked,
                onChanged: (val) => setState(() => _isBookmarked = val),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _saveManga,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF8A71),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
                child: Text(isEditing ? 'Update Manga' : 'Add Manga', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.karla(),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Please enter $label' : null,
      ),
    );
  }

  void _saveManga() async {
    if (_formKey.currentState!.validate()) {
      if (_coverPath == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a cover image')));
        return;
      }
      if (_chapterPath == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a chapter file')));
        return;
      }

      final manga = Manga(
        id: widget.manga?.id,
        title: _titleController.text,
        description: _descriptionController.text,
        authors: _authorsController.text,
        rating: _ratingController.text,
        favorites: _favoritesController.text,
        status: _statusController.text,
        isBookmarked: _isBookmarked,
        coverPage: _coverPath!,
        chapter: _chapterPath!,
        genres: _genresController.text.split(',').map((e) => e.trim()).toList(),
      );

      final provider = Provider.of<MangaProvider>(context, listen: false);
      if (widget.manga == null) {
        await provider.addManga(manga);
      } else {
        await provider.updateManga(manga);
      }
      if (mounted) Navigator.pop(context);
    }
  }
}
