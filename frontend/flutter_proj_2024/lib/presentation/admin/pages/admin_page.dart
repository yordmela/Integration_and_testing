import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_proj_2024/application/admin/bloc/admin_bloc.dart';
import 'package:flutter_proj_2024/application/admin/bloc/admin_event.dart';
import 'package:flutter_proj_2024/application/admin/bloc/admin_state.dart';
import 'package:flutter_proj_2024/domain/room/room.dart';
import 'package:flutter_proj_2024/shared/widgets/drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  int _currentImageIndex = 0;
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 241, 230),
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      drawer: AppDrawer(),
      body: BlocConsumer<AdminBloc, AdminState>(
        listener: (context, state) {
          if (state is AdminError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
          if (state is ItemDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Item deleted successfully')),
            );
          }
          if (state is ItemAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Item added successfully')),
            );
          }
          if (state is ItemUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Item updated successfully')),
            );
          }
        },
        builder: (context, state) {
          if (state is AdminLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AdminLoaded) {
            return SingleChildScrollView(
              child: Column(
                children: state.rooms.map((room) {
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        room.title,
                        style: const TextStyle(
                          color: Color.fromARGB(255, 95, 65, 65),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 465,
                        child: PageView.builder(
                          itemCount: 1, // Only one image per room for now
                          onPageChanged: (index) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return _buildCard(room);
                          },
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            );
          } else if (state is AdminError) {
            return Center(child: Text('Failed to load rooms: ${state.message}'));
          } else {
            return Center(child: Text('No rooms found.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 252, 241, 230),
        tooltip: 'Add New Room',
        onPressed: () {
          _showAddNewDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCard(Room room) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      color: const Color.fromARGB(255, 244, 229, 212),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            kIsWeb
                ? Image.network(
                    room.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  )
                : Image.file(
                    File(room.image),
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.error);
                    },
                  ),
            const Divider(color: Color.fromARGB(255, 208, 188, 188)),
            Text(
              room.description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 95, 65, 65),
              ),
            ),
            Text(
              'Price: \$${room.price}',
              style: const TextStyle(
                color: Color.fromARGB(255, 95, 65, 65),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _showEditDialog(context, room),
                  child: const Text(
                    'Edit',
                    style: TextStyle(color: Colors.blue),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 231, 228, 226),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    context.read<AdminBloc>().add(DeleteItemEvent(room.id));
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(color: Color.fromARGB(255, 243, 33, 33)),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color.fromARGB(255, 231, 228, 226),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(Function(XFile) onImagePicked) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePicked(pickedFile);
    }
  }

  void _showAddNewDialog(BuildContext context) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  XFile? dialogSelectedImage;

  showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 252, 241, 230),
            title: const Text('Add New Room'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: categoryController,
                  decoration: InputDecoration(labelText: 'Category'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    await _pickImage((file) {
                      setState(() {
                        dialogSelectedImage = file;
                      });
                    });
                  },
                  child: const Text('Pick Image'),
                ),
                if (dialogSelectedImage != null)
                  kIsWeb
                      ? Image.network(
                          dialogSelectedImage!.path,
                          height: 200,
                        )
                      : Image.file(
                          File(dialogSelectedImage!.path),
                          height: 200,
                        ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (dialogSelectedImage != null) {
                    try {
                      final imageBytes = await dialogSelectedImage!.readAsBytes();
                      final base64Image = base64Encode(imageBytes);
                      print('Base64 Image: $base64Image'); // Debug statement

                      final room = Room(
                        id: '', // The backend will generate the ID
                        title: titleController.text,
                        description: descriptionController.text,
                        price: double.parse(priceController.text),
                        category: categoryController.text,
                        image: base64Image,
                      );
                      print('Room to be added: $room'); // Debug statement
                      context.read<AdminBloc>().add(AddItemEvent(room));
                      Navigator.of(context).pop();
                    } catch (e) {
                      print('Error encoding image: $e'); // Debug statement
                    }
                  }
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      );
    },
  );
}


  void _showEditDialog(BuildContext context, Room room) {
    final titleController = TextEditingController(text: room.title);
    final descriptionController = TextEditingController(text: room.description);
    final priceController = TextEditingController(text: room.price.toString());
    final categoryController = TextEditingController(text: room.category);
    XFile? dialogSelectedImage;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 252, 241, 230),
              title: const Text('Edit Room'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    controller: categoryController,
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await _pickImage((file) {
                        setState(() {
                          dialogSelectedImage = file;
                        });
                      });
                    },
                    child: const Text('Pick Image'),
                  ),
                  if (dialogSelectedImage != null)
                    kIsWeb
                        ? Image.network(
                            dialogSelectedImage!.path,
                            height: 200,
                          )
                        : Image.file(
                            File(dialogSelectedImage!.path),
                            height: 200,
                          ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final updatedRoom = Room(
                        id: room.id,
                        title: titleController.text,
                        description: descriptionController.text,
                        price: double.parse(priceController.text),
                        category: categoryController.text,
                        image: dialogSelectedImage != null
                            ? base64Encode(await dialogSelectedImage!.readAsBytes())
                            : room.image,
                      );
                      context.read<AdminBloc>().add(UpdateItemEvent(updatedRoom));
                      Navigator.of(context).pop();
                    } catch (e) {
                      print('Error updating room: $e');
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
