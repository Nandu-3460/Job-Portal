# Job Portal for Fresh Graduates 🎓💼

An academic college project built with **Flutter Web** and **Dart** designed to solve the entry-level employment dilemma for recent college graduates.

---

## 📌 Project Overview

College graduates often encounter a frustrating catch-22: entry-level job postings that demand 2–5 years of commercial experience. **Job Portal for Fresh Graduates** provides a clean, targeted platform showcasing verified starter jobs, graduate engineer trainee programs, and paid internships requiring **0 years of prior experience**.

This project aligns directly with the United Nations Sustainable Development Goals:
- **SDG 8: Decent Work & Economic Growth** — expanding youth employment pathways.
- **SDG 10: Reduced Inequalities** — democratizing access to job opportunities across institutions and backgrounds.

---

## 🚀 Key Features

1. **Home Page & Discovery**:
   - Hero banner with quick keyword search.
   - Project overview and SDG alignment overview.
   - Featured graduate opportunities.
   - Highlight metrics (12+ Starter Roles, 0 Experience Required, Verified Firms, 100% Free).

2. **Find Jobs Page**:
   - 12 predefined sample jobs with roles, locations, salaries, and technical skill requirements.
   - Live search by job title, company name, or skills.
   - Filter by job type: *All*, *Full-time*, and *Internship*.
   - Direct *View Details* and *Apply* buttons.

3. **Job Details Modal**:
   - In-depth role descriptions, eligibility criteria, and required skills tags.
   - Direct *Apply Now* action with instant duplicate check.

4. **Application Submission Form**:
   - Captures candidate full name, email address, degree/education, graduation year (batch), and skill sets.
   - Client-side validation for required inputs and email formatting.
   - Interactive confirmation dialog with one-click navigation to submitted applications.
   - **Duplicate Application Prevention**: Prevents applying multiple times for the same job within the current session.

5. **My Applications Tracker**:
   - Real-time display of all applications submitted during the session.
   - Details role, company, applicant details, submission date/time, and status badge (`Applied`).
   - Friendly empty-state illustration when no applications have been submitted.

6. **About & SDG Impact Page**:
   - Academic capstone documentation with student and guide details.
   - Comprehensive explanation of SDG 8 and SDG 10 impact.
   - System module breakdown and architectural summary.

7. **Responsive & Modern UI**:
   - Designed with Google Material 3 standards.
   - Professional blue and white color scheme.
   - Responsive layouts optimized for both desktop monitors and mobile screens.

---

## 🛠️ Technology Stack

- **Framework**: Flutter Web (SDK ^3.13.2+)
- **Language**: Dart
- **Design System**: Material 3 UI (Adaptive layout, Material cards, chips, dialogs)
- **State Management**: Built-in `StatefulWidget` and `setState`
- **Architecture**: In-memory list storage (No external backend or Firebase required)

---

## 📂 Project Structure

```text
lib/
├── main.dart                  # Application entry point and Material 3 theme configuration
├── data/
│   └── sample_jobs.dart       # Predefined curated job listings for fresh graduates
├── models/
│   ├── job.dart               # Job entity data model
│   └── application.dart       # Job application submission data model
├── screens/
│   ├── main_screen.dart       # Core scaffold, responsive navigation & in-memory state
│   ├── home_tab.dart          # Home landing page with search, stats, and featured jobs
│   ├── find_jobs_tab.dart     # Searchable job catalog with filters
│   ├── my_applications_tab.dart # Submitted applications tracking page
│   └── about_tab.dart         # Mission, SDG impact, and academic submission info
└── widgets/
    ├── job_card.dart          # Reusable job item card widget
    ├── job_details_dialog.dart # Modal dialog for full job description & eligibility
    ├── apply_dialog.dart      # Application form modal with input validation
    └── sdg_section.dart       # UN SDG 8 and SDG 10 educational impact widget
```

---

## 💻 Prerequisites & Setup

### 1. Requirements
- Flutter SDK installed (version 3.13 or higher).
- Google Chrome browser.

Verify your Flutter installation:
```bash
flutter doctor
```

### 2. Running Locally in Chrome

Run the development web server:
```bash
flutter run -d chrome
```

### 3. Running Automated Tests

Run smoke tests and the end-to-end user workflow test:
```bash
flutter test
```

### 4. Code Quality & Linting

Verify that code follows Dart guidelines:
```bash
flutter analyze
```

### 5. Building for Production

Compile the web release build:
```bash
flutter build web
```
The compiled static assets will be located in the `build/web/` directory.

---

## ⚠️ Important Limitations (Academic Demonstration)

- **In-Memory Session Storage**: Application data is maintained in-memory using Flutter's `setState`. Applications submitted during a session will reset if the browser tab is refreshed or reopened.
- **Predefined Listings**: Job listings are populated from local Dart models for demonstration purposes.
- **Scope**: No external backend database, cloud authentication, employer management portal, or administrative dashboards are included, keeping the codebase simple and easy to understand for evaluation.

---

## 👥 Student & Academic Submission Details

- **Project Title**: Job Portal for Fresh Graduates
- **Student Name**: `[Enter Student Name]`
- **Roll Number / Registration ID**: `[Enter Roll Number]`
- **Department**: Department of Computer Science & Engineering / Information Technology
- **Institution**: `[Enter College / University Name]`
- **Project Supervisor**: `[Enter Guide / Faculty Name]`
- **Academic Year**: 2026 - 2027
