import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PrescriptionDialog extends StatefulWidget {
  final Function(File?) onUpload;

  const PrescriptionDialog({
    Key? key,
    required this.onUpload,
  }) : super(key: key);

  @override
  State<PrescriptionDialog> createState() => _PrescriptionDialogState();
}

class _PrescriptionDialogState extends State<PrescriptionDialog> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            const Text(
              'Upload Prescription',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Image Preview Section
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[400]!),
              ),
              child: _selectedImage != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                ),
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_outlined,
                    size: 60,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'No image selected',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Pick Image Button
            OutlinedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.add_photo_alternate),
              label: Text(_selectedImage != null ? 'Change Image' : 'Select Image'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
            const SizedBox(height: 20),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Cancel Button
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 12),

                // Upload Button
                ElevatedButton(
                  onPressed: _selectedImage != null
                      ? () {
                    widget.onUpload(_selectedImage);
                    Navigator.of(context).pop();
                  }
                      : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child:  Text(
                    'Upload',
                    style: TextStyle(fontSize: 16,color: _selectedImage != null ? Colors.white : Colors.grey),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Function to show the dialog (place this at the top level of your file)
void showPrescriptionDialog(BuildContext context, Function(File?) onUpload) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => PrescriptionDialog(onUpload: onUpload),
  );
}

// Example usage in your code:
/*
print("product type :- ${widget.product.productType}");
if(widget.product.isPrescriptionRequired ?? false){
  showPrescriptionDialog(context, (File? image) {
    if (image != null) {
      print('Prescription uploaded: ${image.path}');

      // You can now:
      // 1. Upload to server
      // 2. Save to local storage
      // 3. Add to cart with prescription
      // 4. Show success message

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Prescription uploaded successfully')),
      );

      // Proceed with adding product to cart or next action
    }
  });
}
*/