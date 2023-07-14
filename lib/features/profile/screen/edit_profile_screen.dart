import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gurme/common/constants/asset_constants.dart';
import 'package:gurme/common/constants/route_constants.dart';
import 'package:gurme/common/utils/show_toast.dart';
import 'package:image_picker/image_picker.dart';

enum ImageName {
  profile,
  banner;
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? selectedBanner;
  File? selectedProfile;

  Future selectFile(ImageName imageName, ImageSource imageSource) async {
    late XFile? result;
    try {
      result = await ImagePicker().pickImage(source: imageSource);
    } catch (e) {
      showToast(e.toString());
    }
    if (result == null) return;

    setState(() {
      if (imageName == ImageName.banner) {
        selectedBanner = File(result!.path);
      } else {
        selectedProfile = File(result!.path);
      }
    });
  }

  Future uploadFile() async {
    // TODO
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(225),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          flexibleSpace: SizedBox(
            height: 225,
            child: Stack(
              children: [
                SizedBox(
                  height: 175,
                  child: InkWell(
                    onTap: () {
                      cameraOrGallery(
                        context: context,
                        imageName: ImageName.banner,
                        selectFile: selectFile,
                      );
                    },
                    splashFactory: NoSplash.splashFactory,
                    child: Stack(
                      fit: StackFit.expand,
                      alignment: AlignmentDirectional.center,
                      children: [
                        Positioned.fill(
                          child: Container(
                            foregroundDecoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  blurStyle: BlurStyle.outer,
                                  color: Colors.black,
                                  offset: Offset(0, -4),
                                  spreadRadius: 4,
                                )
                              ],
                            ),
                            child: selectedBanner != null
                                ? Image.file(
                                    selectedBanner!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    AssetConstants.defaultBannerPic,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const Icon(
                          Icons.add_a_photo_rounded,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 40,
                  child: Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        cameraOrGallery(
                          context: context,
                          imageName: ImageName.profile,
                          selectFile: selectFile,
                        );
                      },
                      splashFactory: NoSplash.splashFactory,
                      customBorder: const CircleBorder(),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 100,
                            foregroundDecoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xFFCFD3ED),
                                width: 3,
                              ),
                              shape: BoxShape.circle,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.25),
                                  offset: const Offset(0, 2),
                                  spreadRadius: 4,
                                )
                              ],
                            ),
                            child: selectedProfile != null
                                ? CircleAvatar(
                                    radius: 50,
                                    backgroundImage: FileImage(
                                      selectedProfile!,
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundImage: NetworkImage(
                                      AssetConstants.defaultProfilePic,
                                    ),
                                  ),
                          ),
                          const Icon(
                            Icons.add_a_photo_rounded,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            ListTile(
              title: Text(
                "Bilgilerin",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                context.pushNamed(RouteConstants.editNameScreen);
              },
              title: Text(
                "Ad Soyad",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Kullanıcın Ad Soyadı",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  )
                ],
              ),
            ),
            ListTile(
              onTap: () {
                // TODO : Sıfırlama Mail
              },
              title: Text(
                "Şifre",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Sıfırlama Bağlantısını Gönder",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 1.2,
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            ListTile(
              title: Text(
                "Hesaplarını Bağla",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            ListTile(
              onTap: () {}, // TODO : Google Link
              title: Text(
                "Google",
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Google Hesabını Bağla",
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> cameraOrGallery(
      {required BuildContext context,
      required ImageName imageName,
      required Function(ImageName, ImageSource) selectFile}) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.elliptical(20, 17),
          topRight: Radius.elliptical(20, 17),
        ),
      ),
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                height: 60,
                decoration: ShapeDecoration(
                  shape: const StadiumBorder(),
                  shadows: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    selectFile(imageName, ImageSource.gallery);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    backgroundColor: Colors.indigo.shade400,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.image_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Galeriden Seç",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              "YA DA",
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Container(
                height: 60,
                decoration: ShapeDecoration(
                  shape: const StadiumBorder(),
                  shadows: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    selectFile(imageName, ImageSource.camera);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    backgroundColor: Colors.indigo.shade400,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Kamerayı Kullan",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        );
      },
    );
  }
}