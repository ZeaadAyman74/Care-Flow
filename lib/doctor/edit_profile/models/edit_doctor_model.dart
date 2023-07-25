class EditDoctorProfileModel {
   String? name;
   String? phone;
   String? about;
   String? address;
   String? profileImage;

  EditDoctorProfileModel({
     this.name,
     this.phone,
     this.about,
     this.address,
     this.profileImage,
});

 Map<String,dynamic> toJson(){
   return {
     'name': name,
     'phone':phone,
     'about':about,
     'address':address,
    'profile image':profileImage,

   };
 }
}