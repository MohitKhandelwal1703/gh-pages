class AppConstants {
  static const String name = "Mohit Khandelwal";
  static const String title = "Senior Mobile Developer/TeamLead";
  static const String email = "mkhandelwal.mk@gmail.com";
  static const String location = "Jaipur";
  static const String aboutMe = "Mobile App Developer with 8+ years of experience in designing, developing, and optimizing Android and Flutter applications for mobile and tablet devices. Skilled in building dynamic, responsive, and scalable apps, migrating apps ensuring seamless user experiences. Passionate about crafting high-performance, user-centric applications that drive innovation and engagement";
  static const String resumeUrl = "https://drive.google.com/uc?export=download&id=YOUR_GOOGLE_DRIVE_FILE_ID";

  static const List<Map<String, String>> navigationItems = [
    {"title": "Home", "route": "/"},
    {"title": "About", "route": "/about"},
    {"title": "Projects", "route": "/projects"},
    {"title": "Experience", "route": "/experience"},
    {"title": "Contact", "route": "/contact"},
  ];

  static const List<Map<String, String>> socialLinks = [
    {
      "name": "GitHub",
      "url": "https://github.com/yourusername",
      "icon": "assets/icons/github.svg"
    },
    {
      "name": "LinkedIn",
      "url": "https://linkedin.com/in/yourusername",
      "icon": "assets/icons/linkedin.svg"
    },
    {
      "name": "Twitter",
      "url": "https://twitter.com/yourusername",
      "icon": "assets/icons/twitter.svg"
    },
  ];

  static const List<Map<String, dynamic>> projects = [
    {
      "title": "Project 1",
      "description": "A brief description of your first project",
      "image": "assets/images/project1.svg",
      "technologies": ["Flutter", "Firebase", "GetX"],
      "playStoreUrl": "https://play.google.com/store/apps/details?id=com.example.app1",
      "githubUrl": "https://github.com/yourusername/project1"
    },
    {
      "title": "Project 2",
      "description": "A brief description of your second project",
      "image": "assets/images/project2.svg",
      "technologies": ["Android", "Kotlin", "MVVM"],
      "playStoreUrl": "https://play.google.com/store/apps/details?id=com.example.app2",
      "githubUrl": "https://github.com/yourusername/project2"
    },
    // Add more projects here
  ];

  static const List<Map<String, dynamic>> experience = [



    {
      "company": "Clover IT Services Pvt Ltd | Jaipur, India",
      "position": "Senior Software Developer (Team Lead)",
      "duration": "03/2021 - Present",
      "description": "Key responsibilities and achievements",
      "technologies": ["Flutter", "Android", "Java","Cursor-AI","Firebase","Kotlin"]
    },
    {
      "company": "Company Innovana
      "position": "Mobile Developer",
      "duration": "2018 - 2020",
      "description": "Key responsibilities and achievements",
      "technologies": ["Java", "Android", "Firebase"]
    },

    {
      "company": "Company 2",
      "position": "Mobile Developer",
      "duration": "2018 - 2020",
      "description": "Key responsibilities and achievements",
      "technologies": ["Java", "Android", "Firebase"]
    },
    // Add more experience items here
  ];
} 