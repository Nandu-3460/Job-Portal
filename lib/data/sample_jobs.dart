import 'package:flutter/material.dart';
import '../models/job.dart';

/// Predefined list of sample jobs curated for fresh graduates and entry-level talent.
final List<Job> sampleJobs = [
  const Job(
    id: 'job-101',
    title: 'Junior Flutter Developer',
    company: 'TechPulse Solutions',
    location: 'Bengaluru, India (Hybrid)',
    jobType: 'Full-time',
    salary: '₹4.5 - ₹6.5 LPA',
    requiredSkills: ['Flutter', 'Dart', 'REST APIs', 'Git', 'OOP'],
    description:
        'We are seeking an enthusiastic Junior Flutter Developer to join our core mobile engineering team. You will build cross-platform mobile and web applications, collaborate with UI/UX designers, and learn best practices in state management and testing under experienced mentors.',
    eligibility:
        'Bachelor\'s degree in Computer Science, IT, or related fields (2024/2025/2026 Batch). Basic project experience with Flutter & Dart.',
    isFeatured: true,
    postedDate: '1 day ago',
    companyIcon: Icons.phone_android,
  ),
  const Job(
    id: 'job-102',
    title: 'Graduate Software Engineer Trainee',
    company: 'Infoserve Global',
    location: 'Hyderabad, India (On-site)',
    jobType: 'Full-time',
    salary: '₹4.0 - ₹5.5 LPA',
    requiredSkills: ['Java', 'SQL', 'Data Structures', 'Algorithms', 'C++'],
    description:
        'Join our foundational graduate engineering program. Successful candidates undergo structured 3-month technical bootcamps on enterprise Java, database modeling, and automated testing before deployment to high-impact client projects.',
    eligibility:
        'B.Tech / B.E. / MCA in CSE, ECE, or IT with minimum 60% aggregate. Strong problem-solving aptitude.',
    isFeatured: true,
    postedDate: 'Just now',
    companyIcon: Icons.computer,
  ),
  const Job(
    id: 'job-103',
    title: 'Frontend Web Intern (React & Vue)',
    company: 'CloudNova Labs',
    location: 'Remote',
    jobType: 'Internship',
    salary: '₹20,000 / month',
    requiredSkills: ['HTML5', 'CSS3', 'JavaScript', 'React', 'Responsive Design'],
    description:
        'Exciting 6-month internship with potential for full-time conversion based on performance. You will assist our design system team in creating accessible, fast web components for our SaaS platform.',
    eligibility:
        'Pre-final or final year engineering / BCA students. Portfolio or GitHub links showcasing web projects is a plus.',
    isFeatured: true,
    postedDate: '2 days ago',
    companyIcon: Icons.web,
  ),
  const Job(
    id: 'job-104',
    title: 'Associate QA & Test Automation Engineer',
    company: 'NexaTech Systems',
    location: 'Pune, India (On-site)',
    jobType: 'Full-time',
    salary: '₹3.8 - ₹5.0 LPA',
    requiredSkills: ['Manual Testing', 'Selenium Basics', 'Java / Python', 'Bug Reporting', 'SQL'],
    description:
        'Kickstart your career in Quality Assurance. You will write comprehensive test cases, perform manual regression checks, and gradually implement automated test scripts using modern CI/CD pipelines.',
    eligibility:
        'Graduates from CS, IT, BCA, or MCA. Good understanding of Software Development Life Cycle (SDLC) and STLC.',
    isFeatured: false,
    postedDate: '3 days ago',
    companyIcon: Icons.bug_report,
  ),
  const Job(
    id: 'job-105',
    title: 'Junior Data Analyst',
    company: 'DataSphere Insights',
    location: 'Mumbai, India (Hybrid)',
    jobType: 'Full-time',
    salary: '₹4.8 - ₹6.2 LPA',
    requiredSkills: ['Python', 'SQL', 'Power BI / Tableau', 'Excel', 'Statistics'],
    description:
        'Work closely with senior business analysts to clean, transform, and visualize large datasets. Help build interactive business intelligence dashboards for retail and finance clients.',
    eligibility:
        'Degree in Statistics, Mathematics, Economics, Data Science, or Computer Science. Passion for data exploration.',
    isFeatured: true,
    postedDate: '3 days ago',
    companyIcon: Icons.analytics,
  ),
  const Job(
    id: 'job-106',
    title: 'Associate Cloud & DevOps Trainee',
    company: 'SkyBridge Cloud',
    location: 'Bengaluru, India (Hybrid)',
    jobType: 'Full-time',
    salary: '₹5.0 - ₹7.0 LPA',
    requiredSkills: ['Linux', 'AWS Basics', 'Docker', 'Bash Scripting', 'Networking'],
    description:
        'Learn to deploy, monitor, and scale infrastructure in the cloud. You will receive hands-on training with AWS architecture, containerization with Docker, and GitOps workflows.',
    eligibility:
        'B.Tech / B.E. in CS/IT. Certification in AWS Certified Cloud Practitioner is advantageous but not mandatory.',
    isFeatured: false,
    postedDate: '4 days ago',
    companyIcon: Icons.cloud,
  ),
  const Job(
    id: 'job-107',
    title: 'Junior UI/UX Designer',
    company: 'PixelCraft Studios',
    location: 'Remote',
    jobType: 'Internship',
    salary: '₹22,000 / month',
    requiredSkills: ['Figma', 'Wireframing', 'Prototyping', 'User Research', 'Design Systems'],
    description:
        'We love fresh design thinking! Create engaging user flows, wireframes, and interactive prototypes for consumer applications. Work directly with product managers and frontend developers.',
    eligibility:
        'Graduates in Design, HCI, Multimedia, or self-taught designers with a compelling Figma / Behance portfolio.',
    isFeatured: false,
    postedDate: '4 days ago',
    companyIcon: Icons.design_services,
  ),
  const Job(
    id: 'job-108',
    title: 'Graduate Business Analyst',
    company: 'StratEdge Consulting',
    location: 'Gurugram, Delhi NCR (On-site)',
    jobType: 'Full-time',
    salary: '₹4.2 - ₹5.8 LPA',
    requiredSkills: ['Business Communication', 'MS Excel', 'Agile / Scrum', 'Documentation', 'Jira'],
    description:
        'Bridge business needs with technical deliverables. Document requirement specifications, coordinate sprint planning meetings, and facilitate communication between stakeholders and development squads.',
    eligibility:
        'BBA, MBA, B.Tech, or B.Com graduates with exceptional communication and analytical problem-solving skills.',
    isFeatured: false,
    postedDate: '5 days ago',
    companyIcon: Icons.assessment,
  ),
  const Job(
    id: 'job-109',
    title: 'Junior Python Backend Developer',
    company: 'CodeMatrix Innovations',
    location: 'Chennai, India (Hybrid)',
    jobType: 'Full-time',
    salary: '₹4.5 - ₹6.0 LPA',
    requiredSkills: ['Python', 'FastAPI / Django', 'PostgreSQL', 'Git', 'REST APIs'],
    description:
        'Build fast, secure API endpoints and database services for modern mobile and web applications. Gain experience with asynchronous programming, caching with Redis, and containerized deployments.',
    eligibility:
        'B.E. / B.Tech / BCA / MCA graduates with hands-on hobby or academic projects written in Python.',
    isFeatured: false,
    postedDate: '5 days ago',
    companyIcon: Icons.code,
  ),
  const Job(
    id: 'job-110',
    title: 'Cybersecurity Associate Trainee',
    company: 'ShieldDefend Security',
    location: 'Bengaluru, India (On-site)',
    jobType: 'Full-time',
    salary: '₹5.2 - ₹7.2 LPA',
    requiredSkills: ['Network Security', 'OWASP Top 10', 'Linux', 'Vulnerability Assessment', 'Wireshark'],
    description:
        'Protect critical IT infrastructure. Assist in regular vulnerability assessments, analyze security log alerts, and participate in incident response simulation drills under senior security analysts.',
    eligibility:
        'Graduates in Information Security, Computer Science, or Cyber Forensics. Knowledge of CEH or Security+ concepts appreciated.',
    isFeatured: true,
    postedDate: '6 days ago',
    companyIcon: Icons.security,
  ),
  const Job(
    id: 'job-111',
    title: 'Mobile App Development Intern',
    company: 'AppVentures Inc.',
    location: 'Remote',
    jobType: 'Internship',
    salary: '₹25,000 / month',
    requiredSkills: ['Flutter / React Native', 'Mobile UI', 'API Integration', 'Git'],
    description:
        'Gain intense practical experience building consumer applications that serve thousands of daily active users. Mentorship provided by senior mobile engineers.',
    eligibility:
        'Recent graduates or final year students who have published at least one mobile application or completed an academic capstone.',
    isFeatured: false,
    postedDate: '6 days ago',
    companyIcon: Icons.smartphone,
  ),
  const Job(
    id: 'job-112',
    title: 'Associate Technical Support Engineer',
    company: 'GlobalNet Services',
    location: 'Kolkata, India (On-site)',
    jobType: 'Full-time',
    salary: '₹3.5 - ₹4.5 LPA',
    requiredSkills: ['Troubleshooting', 'Customer Support', 'Windows / Linux OS', 'Networking', 'Ticket Handling'],
    description:
        'Provide Level 1 technical assistance to global enterprise customers. Resolve software configuration problems, diagnose hardware connectivity issues, and document solutions in knowledge bases.',
    eligibility:
        'B.Sc, BCA, Diploma, or Engineering graduates in any technical discipline with good spoken and written English.',
    isFeatured: false,
    postedDate: '1 week ago',
    companyIcon: Icons.support_agent,
  ),
];
