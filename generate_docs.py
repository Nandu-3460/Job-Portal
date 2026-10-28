import docx
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT, WD_ALIGN_VERTICAL
from docx.oxml import OxmlElement
from docx.oxml.ns import qn
import os

def set_cell_background(cell, fill_hex):
    tcPr = cell._tc.get_or_add_tcPr()
    shd = OxmlElement('w:shd')
    shd.set(qn('w:val'), 'clear')
    shd.set(qn('w:color'), 'auto')
    shd.set(qn('w:fill'), fill_hex)
    tcPr.append(shd)

def set_cell_margins(cell, top=100, bottom=100, left=150, right=150):
    tcPr = cell._tc.get_or_add_tcPr()
    tcMar = OxmlElement('w:tcMar')
    for m, val in [('top', top), ('bottom', bottom), ('left', left), ('right', right)]:
        node = OxmlElement(f'w:{m}')
        node.set(qn('w:w'), str(val))
        node.set(qn('w:type'), 'dxa')
        tcMar.append(node)
    tcPr.append(tcMar)

def create_document():
    doc = docx.Document()

    # Page Margins: 1 inch all around
    sections = doc.sections
    for section in sections:
        section.top_margin = Inches(1.0)
        section.bottom_margin = Inches(1.0)
        section.left_margin = Inches(1.0)
        section.right_margin = Inches(1.0)

    # Palette
    PRIMARY_BLUE = RGBColor(21, 101, 192)   # #1565C0
    DARK_NAVY = RGBColor(15, 23, 42)        # #0F172A
    SECONDARY_GRAY = RGBColor(71, 85, 105)  # #475569
    TEXT_BLACK = RGBColor(30, 41, 59)       # #1E293B

    # Normal Style configuration
    normal_style = doc.styles['Normal']
    normal_style.font.name = 'Calibri'
    normal_style.font.size = Pt(11)
    normal_style.font.color.rgb = TEXT_BLACK
    normal_style.paragraph_format.line_spacing = 1.2
    normal_style.paragraph_format.space_after = Pt(6)

    # -----------------------------
    # COVER / TITLE BLOCK
    # -----------------------------
    title_p = doc.add_paragraph()
    title_p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    title_p.paragraph_format.space_before = Pt(36)
    title_p.paragraph_format.space_after = Pt(8)
    run_title = title_p.add_run("PROJECT DOCUMENTATION\nJOB PORTAL FOR FRESH GRADUATES")
    run_title.font.name = 'Calibri'
    run_title.font.size = Pt(24)
    run_title.font.bold = True
    run_title.font.color.rgb = PRIMARY_BLUE

    sub_p = doc.add_paragraph()
    sub_p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    sub_p.paragraph_format.space_after = Pt(28)
    run_sub = sub_p.add_run("A Modern, Accessible Web Application Built with Flutter Web & Dart\nAcademic Capstone & Project Report")
    run_sub.font.size = Pt(13)
    run_sub.font.color.rgb = SECONDARY_GRAY
    run_sub.font.italic = True

    # Metadata Table
    table = doc.add_table(rows=8, cols=2)
    table.alignment = WD_TABLE_ALIGNMENT.CENTER
    table.autofit = False

    meta_data = [
        ("Project Title", "Job Portal for Fresh Graduates"),
        ("Technology Stack", "Flutter Web, Dart, Material 3 UI"),
        ("Student / Candidate Name", "[Candidate Name / Student Name]"),
        ("Roll Number / Reg. ID", "[Student Roll Number / Registration ID]"),
        ("Department / Branch", "Department of Computer Science & Engineering / IT"),
        ("Institution / University", "[College / University Name]"),
        ("Project Supervisor / Guide", "[Faculty Mentor / Supervisor Name]"),
        ("Academic Year", "2026 – 2027"),
    ]

    for i, (label, val) in enumerate(meta_data):
        row = table.rows[i]
        c0 = row.cells[0]
        c1 = row.cells[1]
        c0.width = Inches(2.5)
        c1.width = Inches(4.0)

        c0.text = label
        c1.text = val

        set_cell_margins(c0, 120, 120, 150, 150)
        set_cell_margins(c1, 120, 120, 150, 150)
        set_cell_background(c0, "F1F5F9")
        set_cell_background(c1, "FFFFFF")

        # formatting text
        p0 = c0.paragraphs[0]
        p0.runs[0].font.bold = True
        p0.runs[0].font.size = Pt(10)
        p0.runs[0].font.color.rgb = DARK_NAVY

        p1 = c1.paragraphs[0]
        p1.runs[0].font.size = Pt(10)
        p1.runs[0].font.color.rgb = TEXT_BLACK

    doc.add_page_break()

    # -----------------------------
    # HELPER FUNCTIONS
    # -----------------------------
    def add_heading_1(text):
        h = doc.add_paragraph()
        h.paragraph_format.space_before = Pt(20)
        h.paragraph_format.space_after = Pt(8)
        h.paragraph_format.keep_with_next = True
        r = h.add_run(text)
        r.font.name = 'Calibri'
        r.font.size = Pt(16)
        r.font.bold = True
        r.font.color.rgb = PRIMARY_BLUE
        return h

    def add_heading_2(text):
        h = doc.add_paragraph()
        h.paragraph_format.space_before = Pt(14)
        h.paragraph_format.space_after = Pt(6)
        h.paragraph_format.keep_with_next = True
        r = h.add_run(text)
        r.font.name = 'Calibri'
        r.font.size = Pt(13)
        r.font.bold = True
        r.font.color.rgb = DARK_NAVY
        return h

    def add_bullet(bold_prefix, text):
        p = doc.add_paragraph(style='List Bullet')
        p.paragraph_format.space_after = Pt(4)
        r_bold = p.add_run(bold_prefix + ": ")
        r_bold.font.bold = True
        r_bold.font.color.rgb = DARK_NAVY
        p.add_run(text)
        return p

    def add_callout(text):
        tbl = doc.add_table(rows=1, cols=1)
        tbl.alignment = WD_TABLE_ALIGNMENT.CENTER
        c = tbl.rows[0].cells[0]
        c.width = Inches(6.5)
        set_cell_background(c, "EFF6FF") # light blue
        set_cell_margins(c, 140, 140, 180, 180)
        p = c.paragraphs[0]
        p.paragraph_format.space_after = Pt(0)
        r = p.add_run("ℹ " + text)
        r.font.size = Pt(10)
        r.font.color.rgb = PRIMARY_BLUE
        doc.add_paragraph().paragraph_format.space_after = Pt(6)

    # -----------------------------
    # CHAPTER 1: ABSTRACT
    # -----------------------------
    add_heading_1("1. Abstract")
    doc.add_paragraph(
        "Transitioning from academic coursework to professional employment is one of the most critical challenges "
        "faced by fresh college graduates. Mainstream recruitment platforms predominantly cater to lateral and senior "
        "professionals, often displaying 'entry-level' jobs that paradoxically demand 2 to 5 years of commercial tenure. "
        "This project presents 'Job Portal for Fresh Graduates', a dedicated, responsive single-page web application "
        "engineered using Google's Flutter Web framework and the Dart programming language."
    )
    doc.add_paragraph(
        "The system provides an exclusive, curated repository of starter opportunities, graduate engineer trainee (GET) "
        "positions, and paid internships requiring strictly zero years of prior commercial experience. Built following "
        "Google Material 3 design guidelines and utilizing Flutter's built-in reactive state management (StatefulWidget & setState), "
        "the portal facilitates real-time job searching, categorical filtering (Full-time vs. Internship), in-depth job "
        "specifications inspection, validated candidate profile submission, duplicate application prevention, and active session "
        "tracking under 'My Applications'. The project demonstrates concrete alignment with the United Nations Sustainable "
        "Development Goals (SDG 8: Decent Work & Economic Growth and SDG 10: Reduced Inequalities)."
    )

    # -----------------------------
    # CHAPTER 2: INTRODUCTION & PROBLEM STATEMENT
    # -----------------------------
    add_heading_1("2. Introduction & Problem Statement")
    add_heading_2("2.1 Introduction")
    doc.add_paragraph(
        "Modern employment search has transitioned almost entirely to digital channels. However, existing employment "
        "ecosystems are heavily monetized around experienced talent. Fresh graduates from universities and colleges "
        "frequently find themselves disenfranchised by recruitment platforms that feature irrelevant search results, "
        "unrealistic qualification criteria, intrusive advertisements, and mandatory subscription paywalls."
    )
    add_heading_2("2.2 Problem Statement: The Fresh Graduate Paradox")
    doc.add_paragraph(
        "New graduates encounter a classic Catch-22 in their job search:"
    )
    add_bullet("The Experience Dilemma", "To secure an entry-level position, employers ask for commercial experience; yet to attain commercial experience, one must first secure an entry-level job.")
    add_bullet("Search Noise & Mismatch", "Filtering through thousands of postings tagged 'junior' often reveals hidden requirements like '3+ years with production AWS architecture' in the fine print.")
    add_bullet("Campus Placement Disparity", "Not all universities have extensive on-campus placement drives. Students in Tier-2 and Tier-3 institutions require transparent, direct channels to discover verified entry-level roles.")
    add_bullet("Application Friction", "Traditional boards mandate lengthy resume uploads, tedious multi-page account creation, and third-party tracking links before allowing candidates to express interest.")

    # -----------------------------
    # CHAPTER 3: OBJECTIVES & SCOPE
    # -----------------------------
    add_heading_1("3. Project Objectives & System Scope")
    add_heading_2("3.1 Core Objectives")
    add_bullet("Tailored Job Discovery", "Develop an intuitive web portal strictly reserved for jobs and internships that accept fresh college graduates.")
    add_bullet("Real-Time Search & Filtering", "Provide instant search by job title, company name, or programming skills, alongside job-type filtering.")
    add_bullet("Detailed Role Specifications", "Offer modal dialogs presenting comprehensive job descriptions, eligibility criteria, required skills tags, and transparent compensation.")
    add_bullet("Validated Application Submission", "Implement client-side validation ensuring candidates submit valid contact credentials and relevant technical competencies.")
    add_bullet("Duplicate Protection", "Prevent candidates from inadvertently applying multiple times to the same role within the active session.")
    add_bullet("In-Memory Session Dashboard", "Maintain a 'My Applications' tracker displaying applied positions, companies, submission dates, and status chips.")
    add_bullet("UN SDG Alignment", "Highlight tangible academic contributions to SDG 8 and SDG 10.")

    add_heading_2("3.2 System Scope & Academic Boundaries")
    add_callout(
        "Project Scope Notice: This application is developed as an academic demonstration project. "
        "Data persistence is maintained in-memory for the current browser session using Flutter's built-in state. "
        "In accordance with project guidelines, external cloud backends (Firebase), persistent databases, and employer login "
        "portals are excluded to keep the codebase clean, understandable, and self-contained."
    )

    # -----------------------------
    # CHAPTER 4: COMPARATIVE ANALYSIS
    # -----------------------------
    add_heading_1("4. Existing Systems vs. Proposed Portal")
    doc.add_paragraph(
        "The following comparative matrix outlines key distinctions between standard commercial job platforms "
        "and the proposed Job Portal for Fresh Graduates:"
    )

    comp_table = doc.add_table(rows=6, cols=3)
    comp_table.alignment = WD_TABLE_ALIGNMENT.CENTER
    comp_table.autofit = False

    headers = ["Feature / Dimension", "Existing Commercial Portals", "Proposed FreshGrad Portal"]
    for j, h_text in enumerate(headers):
        cell = comp_table.rows[0].cells[j]
        cell.text = h_text
        set_cell_background(cell, "1565C0")
        set_cell_margins(cell, 120, 120, 140, 140)
        p = cell.paragraphs[0]
        p.runs[0].font.bold = True
        p.runs[0].font.color.rgb = RGBColor(255, 255, 255)
        p.runs[0].font.size = Pt(10)

    rows_data = [
        ("Target Demographic", "Mid-to-senior experienced professionals", "Exclusively fresh graduates and interns"),
        ("Experience Requirements", "Typically 2–5+ years, even for junior roles", "Strictly 0 years / College degree holders"),
        ("Search Precision", "Requires complex negative keyword filtering", "100% of listings are curated for graduates"),
        ("User Experience", "Cluttered with ads, sponsored posts, upsells", "Clean, ad-free Material 3 single-page UI"),
        ("Application Complexity", "Tedious multi-step resume parsers & accounts", "Lightweight, direct, validated modal form"),
    ]

    for i, row_data in enumerate(rows_data):
        row = comp_table.rows[i + 1]
        for j, val in enumerate(row_data):
            c = row.cells[j]
            c.text = val
            set_cell_margins(c, 100, 100, 120, 120)
            set_cell_background(c, "F8FAFC" if i % 2 == 0 else "FFFFFF")
            p = c.paragraphs[0]
            p.runs[0].font.size = Pt(9.5)
            if j == 0:
                p.runs[0].font.bold = True

    comp_table.rows[0].cells[0].width = Inches(1.8)
    comp_table.rows[0].cells[1].width = Inches(2.3)
    comp_table.rows[0].cells[2].width = Inches(2.4)

    # -----------------------------
    # CHAPTER 5: SUSTAINABLE DEVELOPMENT GOALS (SDG)
    # -----------------------------
    add_heading_1("5. Sustainable Development Goals (SDG) Alignment")
    doc.add_paragraph(
        "This project actively reflects the United Nations 2030 Agenda for Sustainable Development, "
        "specifically addressing two key global targets:"
    )

    add_heading_2("5.1 SDG 8: Decent Work & Economic Growth")
    doc.add_paragraph(
        "Target 8.6 calls on societies to 'substantially reduce the proportion of youth not in employment, "
        "education, or training.' By assembling verified starter jobs, graduate traineeships, and fairly compensated "
        "internships, the portal empowers young engineering and science graduates to smoothly transition into the productive "
        "digital economy, fostering sustained economic growth and preventing youth underemployment."
    )

    add_heading_2("5.2 SDG 10: Reduced Inequalities")
    doc.add_paragraph(
        "Target 10.3 seeks to 'ensure equal opportunity and reduce inequalities of outcome.' Conventional recruitment "
        "heavily favors candidates from premier metropolitan universities with established alumni networks. "
        "This portal democratizes early career opportunities by making verified jobs visible to all candidates "
        "regardless of geographic location, collegiate tier, or socioeconomic background."
    )

    # -----------------------------
    # CHAPTER 6: SYSTEM ARCHITECTURE & TECH STACK
    # -----------------------------
    add_heading_1("6. Technology Stack & Architectural Design")
    add_heading_2("6.1 Core Technologies")
    add_bullet("Flutter Web (Dart SDK ^3.13.2+)", "Google's open-source multi-platform framework compiled directly for web execution, rendering seamless CanvasKit/HTML interfaces.")
    add_bullet("Dart Language", "Object-oriented, strongly typed client language facilitating modular data modeling and reactive UI rendering.")
    add_bullet("Material 3 UI System", "Implements Google's latest Material 3 design tokens: adaptive cards, tonal action buttons, outline inputs, and semantic status chips.")
    add_bullet("Built-in State Management", "Leverages Flutter's native StatefulWidget and setState architecture. Completely avoids bulky third-party libraries, ensuring code simplicity and clarity.")

    add_heading_2("6.2 Source Code Directory Structure")
    code_struct = (
        "d:/Job-portal2/\n"
        "├── lib/\n"
        "│   ├── main.dart                  # Application entry point & Material 3 blue theme\n"
        "│   ├── data/\n"
        "│   │   └── sample_jobs.dart       # 12 Curated starter job listings\n"
        "│   ├── models/\n"
        "│   │   ├── job.dart               # Job entity data model\n"
        "│   │   └── application.dart       # JobApplication submission data model\n"
        "│   ├── screens/\n"
        "│   │   ├── main_screen.dart       # Scaffold, responsive navigation & in-memory state\n"
        "│   │   ├── home_tab.dart          # Home landing page with hero banner & stats\n"
        "│   │   ├── find_jobs_tab.dart     # Searchable job catalog with type filtering\n"
        "│   │   ├── my_applications_tab.dart # Submitted applications tracker\n"
        "│   │   └── about_tab.dart         # Mission, problem statement & SDG impact\n"
        "│   └── widgets/\n"
        "│       ├── job_card.dart          # Reusable job card component with action buttons\n"
        "│       ├── job_details_dialog.dart # Modal dialog for description & eligibility\n"
        "│       ├── apply_dialog.dart      # Validated application form with duplicate check\n"
        "│       └── sdg_section.dart       # UN SDG 8 and SDG 10 educational impact widget\n"
        "├── test/\n"
        "│   ├── widget_test.dart           # App rendering smoke test\n"
        "│   └── workflow_test.dart         # Complete end-to-end user workflow test\n"
        "├── web/\n"
        "│   ├── index.html                 # HTML web configuration & meta tags\n"
        "│   └── manifest.json              # Web progressive app manifest\n"
        "├── pubspec.yaml                   # Flutter project configuration & assets\n"
        "├── README.md                      # Complete setup & user instructions\n"
        "└── PROJECT_REPORT.md              # Detailed academic documentation\n"
    )
    p_code = doc.add_paragraph()
    r_code = p_code.add_run(code_struct)
    r_code.font.name = 'Consolas'
    r_code.font.size = Pt(8.5)
    p_code.paragraph_format.line_spacing = 1.0

    # -----------------------------
    # CHAPTER 7: MODULES & DETAILED SPECIFICATIONS
    # -----------------------------
    add_heading_1("7. Detailed Module Specifications")

    add_heading_2("7.1 Home & Discovery Module (home_tab.dart)")
    doc.add_paragraph(
        "Serves as the welcome portal for candidates. It comprises:"
    )
    add_bullet("Hero Banner", "Presents project title, mission statement, and an embedded keyword search box allowing direct search transitions.")
    add_bullet("Key Metrics Row", "Features 4 highlight metrics: 12+ Starter Roles, 0 Yrs Required, Verified Firms, and 100% Free.")
    add_bullet("Compact SDG Impact", "Summarizes alignment with UN SDG 8 and SDG 10.")
    add_bullet("Featured Opportunities", "Filters and displays top featured jobs with immediate 'View Details' and 'Apply' actions.")

    add_heading_2("7.2 Find Jobs Module (find_jobs_tab.dart)")
    doc.add_paragraph(
        "A searchable, filterable catalog containing 12 predefined sample roles curated for fresh graduates:"
    )
    jobs_list = [
        "Junior Flutter Developer (TechPulse Solutions - ₹4.5 - ₹6.5 LPA)",
        "Graduate Software Engineer Trainee (Infoserve Global - ₹4.0 - ₹5.5 LPA)",
        "Frontend Web Intern [React/Vue] (CloudNova Labs - ₹20,000 / month)",
        "Associate QA & Test Automation Engineer (NexaTech Systems - ₹3.8 - ₹5.0 LPA)",
        "Junior Data Analyst (DataSphere Insights - ₹4.8 - ₹6.2 LPA)",
        "Associate Cloud & DevOps Trainee (SkyBridge Cloud - ₹5.0 - ₹7.0 LPA)",
        "Junior UI/UX Designer (PixelCraft Studios - ₹22,000 / month)",
        "Graduate Business Analyst (StratEdge Consulting - ₹4.2 - ₹5.8 LPA)",
        "Junior Python Backend Developer (CodeMatrix Innovations - ₹4.5 - ₹6.0 LPA)",
        "Cybersecurity Associate Trainee (ShieldDefend Security - ₹5.2 - ₹7.2 LPA)",
        "Mobile App Development Intern (AppVentures Inc. - ₹25,000 / month)",
        "Associate Technical Support Engineer (GlobalNet Services - ₹3.5 - ₹4.5 LPA)"
    ]
    for j_item in jobs_list:
        add_bullet("Role", j_item)

    add_heading_2("7.3 Job Details Modal (job_details_dialog.dart)")
    doc.add_paragraph(
        "An in-depth modal dialog accessible from any job card. Displays full role description, eligibility criteria "
        "(degree, required academic percentage, eligible batch years), full required skill chips, and a primary action button "
        "('Apply Now' or 'Already Applied' indicator)."
    )

    add_heading_2("7.4 Application Form Modal (apply_dialog.dart)")
    doc.add_paragraph(
        "A structured form dialog enforcing client-side validation rules:"
    )
    add_bullet("Candidate Name", "Mandatory field requiring at least 3 characters.")
    add_bullet("Email Address", "Validated against RFC-standard email regex patterns.")
    add_bullet("Education / Degree", "Captures candidate degree (e.g. B.Tech CS, BCA, B.Sc IT).")
    add_bullet("Graduation Batch", "Selectable dropdown with batches (2023, 2024, 2025, 2026, 2027).")
    add_bullet("Key Skills", "Free-text input for core technical proficiencies.")
    add_bullet("Duplicate Protection", "Intercepts submission if the candidate has already applied to the selected job in the current session.")
    add_bullet("Submission Confirmation", "Displays a confirmation screen with a direct button to review the entry under My Applications.")

    add_heading_2("7.5 My Applications Tracker (my_applications_tab.dart)")
    doc.add_paragraph(
        "Maintains an active record of all jobs applied for during the current session. Each entry displays "
        "the job title, hiring company, candidate name, contact email, education, submitted skills, application timestamp, "
        "and an initial status chip ('Applied'). When no applications exist, an illustrated empty-state card guides the user "
        "back to job discovery."
    )

    # -----------------------------
    # CHAPTER 8: TESTING & VERIFICATION
    # -----------------------------
    add_heading_1("8. Testing & Verification Results")
    doc.add_paragraph(
        "The project has undergone rigorous automated testing, static code analysis, and production build verification:"
    )

    t_table = doc.add_table(rows=4, cols=3)
    t_table.alignment = WD_TABLE_ALIGNMENT.CENTER
    t_table.autofit = False

    t_headers = ["Test Suite / Verification", "Command Executed", "Outcome & Result"]
    for j, h_text in enumerate(t_headers):
        c = t_table.rows[0].cells[j]
        c.text = h_text
        set_cell_background(c, "1565C0")
        set_cell_margins(c, 100, 100, 120, 120)
        p = c.paragraphs[0]
        p.runs[0].font.bold = True
        p.runs[0].font.color.rgb = RGBColor(255, 255, 255)
        p.runs[0].font.size = Pt(10)

    t_rows = [
        ("Static Code Analysis", "flutter analyze", "PASSED: 0 issues found (0 errors, 0 warnings, 0 lints)"),
        ("Widget Smoke Testing", "flutter test test/widget_test.dart", "PASSED: All root UI widgets rendered successfully"),
        ("End-to-End Workflow Test", "flutter test test/workflow_test.dart", "PASSED: Complete 9-step candidate journey validated"),
    ]

    for i, r_data in enumerate(t_rows):
        row = t_table.rows[i + 1]
        for j, val in enumerate(r_data):
            c = row.cells[j]
            c.text = val
            set_cell_margins(c, 100, 100, 120, 120)
            set_cell_background(c, "F8FAFC" if i % 2 == 0 else "FFFFFF")
            p = c.paragraphs[0]
            p.runs[0].font.size = Pt(9.5)
            if j == 2:
                p.runs[0].font.bold = True
                p.runs[0].font.color.rgb = RGBColor(22, 101, 52) # Dark green

    t_table.rows[0].cells[0].width = Inches(2.2)
    t_table.rows[0].cells[1].width = Inches(2.2)
    t_table.rows[0].cells[2].width = Inches(2.1)

    # -----------------------------
    # CHAPTER 9: EXECUTION & USER GUIDE
    # -----------------------------
    add_heading_1("9. Setup & Execution Instructions")
    doc.add_paragraph("To run the project locally:")
    add_bullet("1. Clone or Open Workspace", "Navigate to the project root directory in terminal or command prompt.")
    add_bullet("2. Verify Flutter SDK", "Run 'flutter doctor' to confirm Flutter and Chrome browser support.")
    add_bullet("3. Launch Development Server", "Execute 'flutter run -d chrome' to start the application with hot reload.")
    add_bullet("4. Run Automated Test Suite", "Execute 'flutter test' to run all unit and workflow tests.")
    add_bullet("5. Compile Web Bundle", "Run 'flutter build web' to generate deployable static web assets in 'build/web/'.")

    # -----------------------------
    # CHAPTER 10: CONCLUSION
    # -----------------------------
    add_heading_1("10. Conclusion")
    doc.add_paragraph(
        "The 'Job Portal for Fresh Graduates' successfully addresses the classic experience paradox by delivering "
        "a transparent, distraction-free web application tailored to collegiate job seekers. Developed using Flutter Web, "
        "the application combines clean Material 3 design, responsive desktop/mobile layouts, live search/filtering, "
        "form validation, duplicate prevention, and active session application tracking with complete UN SDG 8 and 10 alignment. "
        "By satisfying all requirements with zero analysis issues and passing automated test suites, the project serves as "
        "an exemplary academic capstone."
    )

    output_path = os.path.join(os.getcwd(), "Job_Portal_Fresh_Graduates_Documentation.docx")
    doc.save(output_path)
    print(f"Document successfully created at: {output_path}")

if __name__ == "__main__":
    create_document()
