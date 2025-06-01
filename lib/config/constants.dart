class AppConstants {
  static const String name = "Mohit Khandelwal";
  static const String title = "Senior Mobile Developer & Team Lead";
  static const String email = "mkhandelwal.mk@gmail.com";
  static const String location = "Jaipur";
  static const String aboutMe =
      "Mobile App Developer with 8+ years of experience in designing, developing, and optimizing Android and Flutter applications for mobile and tablet devices. Skilled in building dynamic, responsive, and scalable apps, migrating apps ensuring seamless user experiences. Passionate about crafting high-performance, user-centric applications that drive innovation and engagement.";
  static const String resumeUrl = "assets/pdf/resume.pdf";

  // 💼 What I Do
  static const List<String> What_I_Do = [
    "✳️ Flutter Development: Cross-platform apps with clean architecture, Riverpod/Provider, and Firebase.",
    "📱 Android Development: Native apps using Kotlin and Java, Jetpack libraries, MVVM/MVI patterns.",
    "🚀 Full App Lifecycle: From wireframing and development to testing, deployment, and maintenance.",
    "🔧 Backend Integration: RESTful APIs, GraphQL, Firestore, SQLite, and real-time sync.",
    "🧠 Team Leadership: Mentoring junior devs, code reviews, and driving agile development practices.",
    "🤖 AI-Enhanced Workflows: Using tools like Cursor AI for accelerated development and code intelligence.",
  ];

  // 🛠 Tech Stack
  static const Map<String, List<String>> Tech_Stack_Categories = {
    "Languages": ["Dart", "Kotlin", "Java", "JavaScript"],
    "Frameworks": ["Flutter", "Jetpack Compose", "Android SDK", "React Native"],
    "Tools": [
      "Firebase",
      "Git",
      "Figma",
      "Postman",
      "JIRA",
      "Cursor AI",
      "ChatGPT"
    ],
    "Architecture": ["MVVM", "Clean Architecture", "BLoC", "Riverpod", "MVC"],
    "Platforms": ["Android", "iOS", "Web", "Windows (Flutter Desktop)"]
  };

  // Legacy Tech Stack (for backward compatibility)
  static const List<String> Tech_Stack = [
    "Languages: Dart, Kotlin, Java",
    "Frameworks: Flutter, Jetpack Compose, Android SDK",
    "Tools: Firebase, Git, Figma, Postman, JIRA, Cursor AI",
    "Architecture: MVVM, Clean Architecture, BLoC, Riverpod",
    "Platforms: Android, iOS, Web, Windows (Flutter Desktop)"
  ];

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
      "url": "https://github.com/MohitKhandelwal1703",
      "icon": "assets/icons/github.svg"
    },
    {
      "name": "LinkedIn",
      "url": "https://www.linkedin.com/in/mohit-khandelwal-972929a0/",
      "icon": "assets/icons/linkedin.svg"
    },
    {
      "name": "Twitter",
      "url": "https://x.com/daksh_mm",
      "icon": "assets/icons/twitter.svg"
    },
  ];

  static const List<Map<String, dynamic>> projects = [
    {
      "title": "Behold Dating App & Web Admin Panel",
      "description": ".",
      "image": "assets/images/project_placeholder.png",
      "technologies": [
        "Flutter-Dart",
        "Android",
        "IOS",
        "Web",
        "FirebaseFirestore",
        "Server-less",
        "No-Api"
      ],
      "Features": [
        "Discover restaurants",
        "Discounts & Deals",
        "Hassle free payment directly at restaurants:",
        "Event's"
      ],
      "playStoreUrl": "UnderDevelopment",
      "githubUrl": ""
    },
    {
      "title": "DealZapp: Save at Restaurants",
      "description": "DealZapp, designed to save money and make your wish-listed hotels, restaurants, lounges & spa-salons more affordable & convenient. DealZapp is the latest way to discover hangout & nightlife places around you, offering you the best of available discounts, through a highly user friendly application.",
      "image": "https://play-lh.googleusercontent.com/-M0yf6A-CkaAUJvQXOWLPaIYSKvp71SRoRQXsIOe8maxdcZ0HjaHLRvm_8bI2t7sCkQ=w2560-h1440-rw",
      "technologies": ["Android", "java", "Firebase", "Rest API"],
      "Features": [
        "Discover restaurants",
        "Discounts & Deals",
        "Hassle free payment directly at restaurants:",
        "Event's"
      ],
      "playStoreUrl":
          "https://play.google.com/store/apps/details?id=co.apnaa.apnaajpr",
      "githubUrl": ""
    },
    {
      "title": "DealZapp Merchant App",
      "description":
          "DealZapp,that Saves Every time you Spend.* Promote personalization, Deals with Best of Restaurant, Lounge, Pubs,Hotel, Spa, Saloons.* Get Notified about new & trending hot spots in market.* Track your record, redeem as per your convenience.",
      "image":
          "https://play-lh.googleusercontent.com/c1-06_QqzJ1Uh2sR3mtTNHUtDNMBrEpVt2wS7sjkrQkaTKWlKP3QAM3U4IQu57PY74C1=w2560-h1440-rw",
      "technologies": [
        "Android",
        "java",
        "Firebase",
        "Rest API's",
      ],
      "Features": [
        "Discover restaurants",
        "Discounts & Deals",
        "Hassle free payment directly at restaurants:",
        "Event's"
      ],
      "playStoreUrl":
          "https://play.google.com/store/apps/details?id=co.dekho.apjp",
      "githubUrl": ""
    },
    {
      "title": "OIDDS (Online Instructor Development & Deployment System)",
      "description":
          "he OIDDS is an online portal for instructors to track their development and deployment, created by CAMP CHALLENGE Pte Ltd for our entire organization including FOCUS Adventure, CAMP CHALLENGE, Outdoor Adventure, and SeaOPS.",
      "image":
          "https://play-lh.googleusercontent.com/h62lw-DVTBJctFhT0xPTVBP_PYzPE52UbC_yhzJWGq395LvZ9N6det75eiFVEs28dRk=w416-h235-rw",
      "technologies": [
        "Flutter-Dart",
        "Android",
        "IOS",
        "Firebase",
        "node API's",
      ],
      "Features": [
        "Adventure specializes",
        "Outdoor Adventure",
        "Track their Outdoor Adventure",
        "Youth character development"
      ],
      "playStoreUrl":
          "https://play.google.com/store/apps/details?id=com.oidds.app",
      "githubUrl": ""
    },
    {
      "title": "TarotLife Live Psychic Reading(4M+ downloads)",
      "description":
          "Start your First Chat with our Trusted Tarot Readers.Problems in love, marriage, career, future or any other aspect of life? Connect with Trusted Psychics & Tarot Readers via Live Chat & Free Tarot Readings to get instant solutions.💯With over 4M+ downloads, Tarot Life has become the most trusted Free Tarot Card Reading App, providing 24x7 Live Chat with experienced psychics. Here you can get the right guidance for all your love, career, marriage, future & finance-related problems. ",
      "image": "https://i.ytimg.com/vi/nsGk84m8C44/hqdefault.jpg",
      "technologies": [
        "Android",
        "java",
        "Firebase",
        "API's",
        "Offline/Online Data"
      ],
      "playStoreUrl":
          "https://play.google.com/store/apps/details?id=com.tarotlife.tarot.card.reading.numerology",
      "Features": [
        "LOVE & RELATIONSHIPS",
        "CAREER",
        "EDUCATION",
        "MATCH-MAKING"
      ],
      "githubUrl": ""
    },
    {
      "title": "Psychology Facts Surprise You",
      "description": "Psychology Facts Amazing Truth Surprise You app is based upon the research & study of behavior, performance, and mental operations. You will enjoy being reading about different categories and at the same time, you can share them with your friends through WhatsApp, Facebook, Instagram, and any other social media.",
      "image": "https://i.ytimg.com/vi/oX5q3b2CmOk/hqdefault.jpg",
      "technologies": ["Android", "java", "Firebase", "Rest API"],
      "Features": [
        "Personality Facts",
        "Happiness Facts",
        "Depression Facts",
        "Love Facts",
        "Emotions Facts",
        "Jealousy Facts",
        "Friendship Facts",
        "& much more categories"
      ],
      "playStoreUrl":
      "https://play.google.com/store/apps/details?id=status.maker.psychology.creator.mind.reader",
      "githubUrl": ""
    },
    {
      "title": "Numerology - Unravel Mysteries",
      "description": "Numerology explores the connection between numbers and our lives. There are nine primary numbers, each with unique meanings.",
      "image": "https://i.ytimg.com/vi/IaI2hef2G3U/hqdefault.jpg",
      "technologies": ["Android", "java", "Firebase", "Rest API"],
      "Features": [
        "Numerology Love Facts",
        "Daily Tips,Colors,Question",
        "Help in Making Right Decisions.",
        "Helps in Improving Your Relationships.",
        "Helps in Figuring Out Who You Are.",
        "Helps in Defining Your Opportunities.",
        "Helps in Improving Your Life."
      ],
      "playStoreUrl":
      "https://play.google.com/store/apps/details?id=free.numerology.calculator.app.best",
      "githubUrl": ""
    },
    {
      "title": "Duplicate Files Remover app",
      "description": "Free Duplicate Files Finder & Remover app finds duplicates from Internal storage and SD Card. Using this app you can find Hidden Duplicate Files from your Android phone",
      "image": "https://i.ytimg.com/vi/3MaLPUdyhiM/hqdefault.jpg",
      "technologies": ["Android", "java", "AIDL","Hash Algo"],
      "Features": [
        "Support for Internal & External Storage",
        "Groups of Duplicates",
        "Cleaning duplicates files",
        " Free Up Chunks of Valuable Storage "
      ],
      "playStoreUrl":
      "https://play.google.com/store/apps/details?id=com.duplicatefilefixer.duplicatefilecleaner.duplicatefileremover.duplicate.files.scanner",
      "githubUrl": ""
    },
  ];
  static const List<Map<String, dynamic>> experience = [
    {
      "company": "Clover IT Services Pvt Ltd",
      "location": "Jaipur, India",
      "position": "Senior Software Developer (Team Lead)",
      "duration": "03/2021 - Present",
      "description": "Key responsibilities and achievements",
      "technologies": [
        "Flutter",
        "Dart",
        "Android",
        "Firebase",
        "Powered-AI (Cursor-AI)",
      ],
      "companyUrl": "https://www.cloveritservices.com/"
    },
    {
      "company": "WinWin App Solutions Pvt Ltd",
      "location": "Jaipur, India",
      "position": "Senior Mobile Developer",
      "duration": "08/2020 - 03/2021",
      "description": "Key responsibilities and achievements",
      "technologies": [
        "Java",
        "Android",
        "Firebase",
      ],
      "companyUrl": "https://www.winwinappsolutions.com"
    },
    {
      "company": "Innovana Thinklabs ltd.",
      "location": "Jaipur, India",
      "position": "Android Mobile Developer",
      "duration": "04/2016 - 07/2020",
      "description": "Key responsibilities and achievements",
      "technologies": ["Java", "Android", "Kotlin"],
      "companyUrl": "https://www.innovanatechlabs.com/"
    },
  ];
}
