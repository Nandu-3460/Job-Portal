# PROJECT REPORT

## PROJECT TITLE: JOB PORTAL FOR FRESH GRADUATES
**An Academic Capstone Project**

---

### STUDENT & INSTITUTIONAL DETAILS

| Parameter | Details |
| :--- | :--- |
| **Project Title** | Job Portal for Fresh Graduates |
| **Candidate Name** | `[Candidate / Student Name]` |
| **Roll Number / Reg ID** | `[Roll Number / Registration Number]` |
| **Degree & Branch** | Bachelor of Technology / Science / BCA in Computer Science & Engineering / IT |
| **Academic Year** | 2026 – 2027 |
| **Project Supervisor / Guide** | `[Faculty Guide / Mentor Name, Designation]` |
| **Department** | Department of Computer Science & Engineering |
| **Institution / University** | `[College / University Name, City]` |

---

## 1. ABSTRACT

The transition from college to the corporate workforce represents a critical phase for graduating students. However, conventional commercial job platforms predominantly feature listings requiring multi-year professional experience, creating an entry barrier commonly known as the "experience paradox." This project presents **Job Portal for Fresh Graduates**, a responsive, accessible web application engineered using Flutter Web and Dart. The system is designed to provide an exclusive repository of starter opportunities, graduate engineer trainee (GET) roles, and technical internships that explicitly welcome candidates with zero prior commercial experience. 

Built with Flutter’s Material 3 design system and local state management (`StatefulWidget` and `setState`), the portal allows students to discover curated positions, apply filters by role type (Full-time vs. Internship), inspect job specifications, and submit job applications through a validated client-side form. Furthermore, it incorporates duplicate application prevention and enables candidates to monitor their application statuses within the active session. This application also demonstrates tangible alignment with the United Nations Sustainable Development Goals: **SDG 8 (Decent Work and Economic Growth)** and **SDG 10 (Reduced Inequalities)** by democratizing access to early-career opportunities.

---

## 2. INTRODUCTION

The contemporary employment ecosystem has undergone significant digital transformation, yet entry-level job seekers continue to face substantial friction. Most commercial recruitment portals are optimized for lateral hiring where algorithms favor candidates with existing employment track records. Consequently, fresh graduates and interns often spend considerable time filtering through thousands of irrelevant listings or feeling disqualified by unrealistic prerequisite requirements.

**Job Portal for Fresh Graduates** addresses this challenge by providing a student-centric recruitment interface tailored specifically to academic institutions and upcoming graduates. By enforcing an entry-level-only criterion, the platform eliminates information asymmetry, simplifies job discovery, and streamlines the application process.

---

## 3. PROBLEM STATEMENT

Graduating college students encounter three primary obstacles in their initial job hunt:
1. **The Experience Paradox**: Entry-level postings on mainstream job platforms frequently stipulate 2 to 5 years of professional experience, making it difficult for new graduates to find true entry positions.
2. **Platform Clutter & Complexity**: Commercial portals require long, convoluted profile creation procedures, mandatory subscription fees, and heavy resume parsing before allowing applications.
3. **Inequality in Visibility**: Students from non-tier-1 institutions often lack direct on-campus placement drives and have limited avenues to discover verified entry-level roles.

---

## 4. OBJECTIVES OF THE PROJECT

The primary objectives of this project are:
1. To design and implement an intuitive, responsive web-based job portal specifically tailored for fresh graduates.
2. To provide an accessible repository of curated entry-level jobs and internships with zero commercial experience prerequisites.
3. To enable real-time keyword search across job titles, corporate organizations, and technical skill sets.
4. To implement categorical filtering to separate full-time opportunities from internships.
5. To develop a robust, validated application submission form with duplicate application detection for the active session.
6. To implement an in-memory session tracking module ("My Applications") displaying submission timestamps and application statuses.
7. To illustrate institutional alignment with UN SDG 8 and SDG 10.

---

## 5. EXISTING VS. PROPOSED SYSTEM

| Feature / Dimension | Existing Commercial Systems | Proposed System (FreshGrad Portal) |
| :--- | :--- | :--- |
| **Target Audience** | Primarily experienced / mid-to-senior professionals | Exclusively fresh graduates, trainees, and interns |
| **Experience Requirement** | Often requires 2–5+ years even for entry tags | Strictly 0 years / College degree holders |
| **User Interface Complexity** | Heavy advertisements, intrusive upsells, complex navigation | Clean, focused, ad-free Material 3 design |
| **Application Process** | Multi-page resumes, third-party redirects | Direct, lightweight, validated modal form |
| **System Overhead** | Heavy backend microservices, large tracking scripts | High-performance single-page web app built with Flutter Web |
| **Cost to Student** | Freemium with paywalled recruiter messaging | 100% Free and open for student demonstration |

---

## 6. TECHNOLOGIES USED

1. **Flutter Web (SDK ^3.13.2+)**:
   - Google’s portable UI framework allowing compiled execution on web browsers via WebAssembly and CanvasKit/HTML renderers.
2. **Dart Language**:
   - Strongly typed, object-oriented client-optimized language powering the business logic and UI tree.
3. **Material 3 Design System**:
   - Modern design tokens, dynamic color schemes, accessible typography, and standard components (Cards, Chips, Dialogs, Badges).
4. **State Management**:
   - Flutter's built-in `StatefulWidget` and `setState` mechanism, providing understandable reactive updates without external dependencies.
5. **Testing Framework**:
   - `flutter_test` suite for smoke testing and complete end-to-end user workflow simulation.

---

## 7. MODULE DESCRIPTION

The application is decomposed into five cohesive modules:

### Module 1: Home & Discovery
- **Hero Banner**: Communicates project objectives and provides an immediate keyword search input.
- **Key Metrics**: Highlights four vital attributes (12+ Starter Roles, 0 Yrs Experience Required, Verified Firms, 100% Free).
- **SDG Overview**: Compact summary of SDG 8 and SDG 10 alignment.
- **Featured Jobs Section**: Displays prominent positions with quick action buttons.

### Module 2: Job Catalog & Filtering ("Find Jobs")
- Lists 12 realistic sample opportunities spanning software development, testing, data analysis, UI/UX design, cloud/DevOps, and cybersecurity.
- Dynamic search querying title, company name, and required skills simultaneously.
- Categorical filter chips (All, Full-time, Internship) for targeted browsing.

### Module 3: Job Specification & Details
- Detailed modal dialog displaying complete job descriptions, candidate eligibility requirements, compensation structure, work format (Remote/Hybrid/On-site), and technology stack tags.
- Direct invocation of the application workflow.

### Module 4: Candidate Application & Validation
- Form collecting:
  - Candidate Full Name (Minimum 3 characters)
  - Email Address (RFC-compliant regex pattern validation)
  - Educational Background & Degree
  - Graduation Year / Batch (Dropdown selection: 2023–2027)
  - Key Skills & Competencies
- Duplicate detection: Checks candidate submissions to prevent re-applying to the same job within the active session.
- Confirmation modal with one-tap transition to the application tracking dashboard.

### Module 5: Session Application Tracker ("My Applications")
- Renders submitted candidate profiles with timestamps, company, role title, and status badges (`Applied`).
- Displays an empty-state screen with a call-to-action button when no applications have been submitted.

---

## 8. SYSTEM WORKFLOW

```text
[User Opens Portal]
        │
        ▼
[Home Page / Hero Search]
        │
        ├───► [Browse Featured Jobs] ───► [Click 'View Details'] ───┐
        │                                                          │
        ▼                                                          ▼
[Find Jobs Catalog] ─────────────► [Filter by Type / Search] ───► [Job Details Dialog]
        │                                                          │
        ▼                                                          ▼
[Click 'Apply Now'] ◄──────────────────────────────────────────────┘
        │
        ▼
[Application Form Modal]
        │
        ├──► [Validate Fields: Name, Email, Degree, Year, Skills]
        │
        ├──► [Check Duplicate Application in Active Session]
        │       ├── If Duplicate: Display Alert Dialog
        │       └── If New: Add to In-Memory List
        ▼
[Success Confirmation Modal]
        │
        ▼
[My Applications Page] ──► [Inspect Submitted Jobs, Timestamps & Status]
```

---

## 9. SUSTAINABLE DEVELOPMENT GOALS (SDG) RELEVANCE

The United Nations 2030 Agenda highlights youth empowerment as a primary driver for sustainable development. This project aligns with two key goals:

### SDG 8: Decent Work and Economic Growth
- **Target 8.6**: Substantially reduce the proportion of youth not in employment, education, or training.
- **Project Contribution**: Connects fresh college graduates directly to verified starter jobs, fair stipends, and structured training programs, preventing underemployment and helping graduates embark on productive careers.

### SDG 10: Reduced Inequalities
- **Target 10.3**: Ensure equal opportunity and reduce inequalities of outcome.
- **Project Contribution**: Eliminates institutional privilege by making entry-level job listings transparently accessible to students across Tier-1, Tier-2, and Tier-3 colleges without discriminatory gatekeeping.

---

## 10. TESTING AND RESULTS

### 10.1 Automated Testing
The application underwent automated testing via Flutter’s testing framework:
1. **App Smoke Test (`test/widget_test.dart`)**:
   - Asserts proper rendering of root widgets, navigation bar elements, and typography.
   - Result: **PASSED**
2. **End-to-End Workflow Test (`test/workflow_test.dart`)**:
   - Automated simulation of complete user journey:
     1. App launch
     2. Searching for "Flutter"
     3. Opening Job Details modal
     4. Clicking "Apply Now"
     5. Completing candidate form fields
     6. Submitting form and verifying success modal
     7. Transitioning to "My Applications" tab and verifying submitted data
     8. Returning to job list to verify duplicate application status badge
   - Result: **PASSED (All 2 test suites passed)**

### 10.2 Code Quality & Static Analysis
- Executed `flutter analyze` across all project files.
- Result: **0 issues found** (0 errors, 0 warnings, 0 lints).

### 10.3 Web Build Verification
- Executed `flutter build web` targeting modern browsers.
- Result: **Web release bundle compiled successfully**.

---

## 11. LIMITATIONS

1. **In-Memory Session Persistence**: Data is preserved strictly within active application state (`setState`). Refreshing the browser clears submitted applications.
2. **Predefined Catalog**: Listings are provided as curated static Dart datasets for evaluation and demonstration purposes.
3. **No External Backend**: Online authentication (OAuth/JWT), persistent cloud databases, and administrative employer consoles are deliberately excluded to ensure an accessible, self-contained academic submission.

---

## 12. CONCLUSION & FUTURE SCOPE

### Conclusion
The **Job Portal for Fresh Graduates** successfully demonstrates that modern cross-platform technologies like Flutter Web can deliver clean, responsive, and accessible recruitment tools tailored to entry-level candidates. By eliminating misleading experience barriers, providing input validation, and incorporating UN SDG principles, this college project fulfills all academic and functional requirements with high code quality and architectural clarity.

### Future Scope
1. **Persistent Backend**: Integration with a REST or GraphQL backend (e.g. Node.js/PostgreSQL) for persistent user profiles.
2. **Resume Upload**: File-picker integration for PDF resume parsing.
3. **Recruiter Portal**: Separate interface for verified employers to post graduate openings and shortlist applicants.
4. **Notification System**: Email alerts for application status progressions.
