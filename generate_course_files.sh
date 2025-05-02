#!/bin/bash

# Base directory for modules
mkdir -p modules

# Function to create HTML file with basic content
create_html_file() {
    local file_path=$1
    local title=$2
    cat << EOF > "$file_path"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$title</title>
</head>
<body>
    <h1>$title</h1>
    <!-- Content to be added -->
</body>
</html>
EOF
}

# Process courses starting from "Applying for University"
start_processing=false
while IFS= read -r line; do
    # Check for course title
    if [[ $line =~ ^[[:space:]]*{[[:space:]]*title:[[:space:]]*\"([^\"]+)\" ]]; then
        course_title="${BASH_REMATCH[1]}"
        if [[ "$course_title" == "Applying for University" ]]; then
            start_processing=true
        fi
        if [[ $start_processing == true ]]; then
            # Create course directory
            course_dir="modules/${course_title// /_}"
            mkdir -p "$course_dir/iframes"
        fi
    fi

    # Process pages within sections
    if [[ $start_processing == true && $line =~ \{[[:space:]]*title:[[:space:]]*\"([^\"]+)\"[[:space:]]*,?[[:space:]]*url:[[:space:]]*\"[^\"]*\" ]] || [[ $start_processing == true && $line =~ \{[[:space:]]*title:[[:space:]]*\"([^\"]+)\" ]]; then
        page_title="${BASH_REMATCH[1]}"
        # Clean page title for filename (replace spaces with underscores, remove special characters)
        clean_page_title=$(echo "$page_title" | tr ' ' '_' | tr -d '😃📚✅🏆⚡️')
        # Create HTML file
        html_file="$course_dir/iframes/${clean_page_title}.html"
        # Handle duplicate filenames by appending a counter
        counter=1
        base_html_file="$html_file"
        while [[ -f "$html_file" ]]; do
            html_file="${base_html_file%*.html}_$counter.html"
            ((counter++))
        done
        create_html_file "$html_file" "$page_title"
        echo "Created: $html_file"
    fi
done < <(cat << 'EOF'
[
    {
        title: "Applying for University",
        sections: [
            {
                title: "Getting Started",
                pages: [
                    { title: "😃 Welcome", url: "modules/Apply_for_University/iframes/Welcome.html" },
                    { title: "📚 All About Your Course", url: "modules/Apply_for_University/iframes/All_About_Your_Course.html" }
                ]
            },
            {
                title: "Section 1: Planning your Application",
                pages: [
                    { title: "What's in this Section?", url: "modules/Apply_for_University/iframes/Whats_in_this_Section.html" },
                    { title: "Your Timeline", url: "modules/Apply_for_University/iframes/Your_Timeline.html" },
                    { title: "Managing your Time", url: "modules/Apply_for_University/iframes/Managing_your_Time.html" },
                    { title: "Identifying your Values", url: "modules/Apply_for_University/iframes/Identifying_your_Values.html" },
                    { title: "Funding for University", url: "modules/Apply_for_University/iframes/Funding_for_University.html" },
                    { title: "Your University Application", url: "modules/Apply_for_University/iframes/Your_University_Application.html" },
                    { title: "Reflect on your Learning", url: "modules/Apply_for_University/iframes/Reflect_on_your_Learning.html" },
                    { title: "End of Section", url: "modules/Apply_for_University/iframes/End_of_Section.html" },
                    { title: "Section 1 Student Feedback", url: "modules/Apply_for_University/iframes/Section_1_Student_Feedback.html" }
                ]
            },
            {
                title: "Section 2: Choosing your Subject",
                pages: [
                    { title: "What's in this Section?", url: "modules/Apply_for_University/iframes/Whats_in_this_Section_2.html" },
                    { title: "Choosing your Subject 1", url: "modules/Apply_for_University/iframes/Choosing_your_Subject_1.html" },
                    { title: "Undiscovered Subjects", url: "modules/Apply_for_University/iframes/Undiscovered_Subjects.html" },
                    { title: "Researching Courses", url: "modules/Apply_for_University/iframes/Researching_Courses.html" },
                    { title: "Choosing your Subject 2", url: "modules/Apply_for_University/iframes/Choosing_your_Subject_2.html" },
                    { title: "Your University Application", url: "modules/Apply_for_University/iframes/Your_University_Application_2.html" },
                    { title: "Reflect on your Learning", url: "modules/Apply_for_University/iframes/Reflect_on_your_Learning_2.html" },
                    { title: "End of Section", url: "modules/Apply_for_University/iframes/End_of_Section_2.html" },
                    { title: "Section 2 Student Feedback", url: "modules/Apply_for_University/iframes/Section_2_Student_Feedback.html" }
                ]
            },
            {
                title: "Section 3: Choosing Universities",
                pages: [
                    { title: "What's in this Section?", url: "modules/Apply_for_University/iframes/Whats_in_this_Section_3.html" },
                    { title: "Other English-speaking Universities", url: "modules/Apply_for_University/iframes/Other_English_speaking_Universities.html" },
                    { title: "Dispelling Myths", url: "modules/Apply_for_University/iframes/Dispelling_Myths.html" },
                    { title: "Different Types of UK University", url: "modules/Apply_for_University/iframes/Different_Types_of_UK_University.html" },
                    { title: "Choosing your University", url: "modules/Apply_for_University/iframes/Choosing_your_University.html" },
                    { title: "Your University Application", url: "modules/Apply_for_University/iframes/Your_University_Application_3.html" },
                    { title: "Reflect on your Learning", url: "modules/Apply_for_University/iframes/Reflect_on_your_Learning_3.html" },
                    { title: "End of Course Summary", url: "modules/Apply_for_University/iframes/End_of_Course_Summary.html" },
                    { title: "Section 3 Student Feedback", url: "modules/Apply_for_University/iframes/Section_3_Student_Feedback.html" }
                ]
            },
            {
                title: "End of Course Assessment Test",
                pages: [
                    { title: "End of Course Assessment Test", url: "modules/Apply_for_University/iframes/End_of_Course_Assessment_Test.html" }
                ]
            },
            {
                title: "Summing up",
                pages: [
                    { title: "Understanding SMART Objectives", url: "modules/Apply_for_University/iframes/Understanding_SMART_Objectives.html" },
                    { title: "Your Personal Development", url: "modules/Apply_for_University/iframes/Your_Personal_Development.html" }
                ]
            }
        ]
    },
    {
        title: "Coding Games with Python",
        sections: [
            {
                title: "Getting Started",
                pages: [
                    { title: "😃 Welcome", url: "modules/Coding_Games_with_Python/iframes/Welcome.html" },
                    { title: "📚 All About Your Course", url: "modules/Coding_Games_with_Python/iframes/All_About_Your_Course.html" },
                    { title: "✅ Check your Coding skills", url: "modules/Coding_Games_with_Python/iframes/Check_your_Coding_skills.html" },
                    { title: "🏆 Course Achievements", url: "modules/Coding_Games_with_Python/iframes/Course_Achievements.html" }
                ]
            },
            {
                title: "Section 1: What is Python?",
                pages: [
                    { title: "Section 1 Introduction", url: "modules/Coding_Games_with_Python/iframes/Section_1_Introduction.html" },
                    { title: "Python Concepts", url: "modules/Coding_Games_with_Python/iframes/Python_Concepts.html" },
                    { title: "Scoolcode Introduction", url: "modules/Coding_Games_with_Python/iframes/Scoolcode_Introduction.html" }
                ]
            },
            {
                title: "Coding Task",
                pages: [
                    { title: "Coding task introduction", url: "modules/Coding_Games_with_Python/iframes/Coding_task_introduction.html" }
                ]
            },
            {
                title: "Section 1 Quiz",
                pages: [
                    { title: "Section 1 Quiz", url: "modules/Coding_Games_with_Python/iframes/Section_1_Quiz.html" }
                ]
            },
            {
                title: "Section 1 Reflection",
                pages: [
                    { title: "Section 1 Reflection", url: "modules/Coding_Games_with_Python/iframes/Section_1_Reflection.html" }
                ]
            },
            {
                title: "Section 1 Summary",
                pages: [
                    { title: "Section 1 Summary", url: "modules/Coding_Games_with_Python/iframes/Section_1_Summary.html" }
                ]
            },
            {
                title: "Extension: Sandbox mode",
                pages: [
                    { title: "Introducing Sandbox mode", url: "modules/Coding_Games_with_Python/iframes/Introducing_Sandbox_mode.html" }
                ]
            },
            {
                title: "Section 2: Conditionals",
                pages: [
                    { title: "Section 2 Introduction", url: "modules/Coding_Games_with_Python/iframes/Section_2_Introduction.html" },
                    { title: "Algorithms", url: "modules/Coding_Games_with_Python/iframes/Algorithms.html" }
                ]
            },
            {
                title: "Coding Task",
                pages: [
                    { title: "Coding task introduction", url: "modules/Coding_Games_with_Python/iframes/Coding_task_introduction_2.html" }
                ]
            },
            {
                title: "Section 2 Quiz",
                pages: [
                    { title: "Section 2 Quiz", url: "modules/Coding_Games_with_Python/iframes/Section_2_Quiz.html" }
                ]
            },
            {
                title: "Section 2 Reflection",
                pages: [
                    { title: "Section 2 Reflection", url: "modules/Coding_Games_with_Python/iframes/Section_2_Reflection.html" }
                ]
            },
            {
                title: "Section 2 Summary",
                pages: [
                    { title: "Section 2 Summary", url: "modules/Coding_Games_with_Python/iframes/Section_2_Summary.html" }
                ]
            },
            {
                title: "Extension: Sandbox mode",
                pages: [
                    { title: "Introducing Sandbox mode", url: "modules/Coding_Games_with_Python/iframes/Introducing_Sandbox_mode_2.html" }
                ]
            },
            {
                title: "Section 3: 'For' Loops",
                pages: [
                    { title: "Section 3 Introduction", url: "modules/Coding_Games_with_Python/iframes/Section_3_Introduction.html" }
                ]
            },
            {
                title: "Coding Task",
                pages: [
                    { title: "Coding task introduction", url: "modules/Coding_Games_with_Python/iframes/Coding_task_introduction_3.html" }
                ]
            },
            {
                title: "Section 3 Quiz",
                pages: [
                    { title: "Section 3 Quiz", url: "modules/Coding_Games_with_Python/iframes/Section_3_Quiz.html" }
                ]
            },
            {
                title: "Section 3 Reflection",
                pages: [
                    { title: "Section 3 Reflection", url: "modules/Coding_Games_with_Python/iframes/Section_3_Reflection.html" }
                ]
            },
            {
                title: "Section 3 Summary",
                pages: [
                    { title: "Section 3 Summary", url: "modules/Coding_Games_with_Python/iframes/Section_3_Summary.html" }
                ]
            },
            {
                title: "Extension: Sandbox mode",
                pages: [
                    { title: "Introducing Sandbox mode", url: "modules/Coding_Games_with_Python/iframes/Introducing_Sandbox_mode_3.html" }
                ]
            },
            {
                title: "Section 4: 'While' Loops",
                pages: [
                    { title: "Section 4 Introduction", url: "modules/Coding_Games_with_Python/iframes/Section_4_Introduction.html" }
                ]
            },
            {
                title: "Coding Task 1",
                pages: [
                    { title: "Coding task introduction", url: "modules/Coding_Games_with_Python/iframes/Coding_task_introduction_4.html" }
                ]
            },
            {
                title: "Coding Task 2",
                pages: [
                    { title: "Coding task introduction", url: "modules/Coding_Games_with_Python/iframes/Coding_task_introduction_5.html" }
                ]
            },
            {
                title: "Section 4 Quiz",
                pages: [
                    { title: "Section 4 Quiz", url: "modules/Coding_Games_with_Python/iframes/Section_4_Quiz.html" }
                ]
            },
            {
                title: "Section 4 Reflection",
                pages: [
                    { title: "Section 4 Reflection", url: "modules/Coding_Games_with_Python/iframes/Section_4_Reflection.html" }
                ]
            },
            {
                title: "Section 4 Summary",
                pages: [
                    { title: "Section 4 Summary", url: "modules/Coding_Games_with_Python/iframes/Section_4_Summary.html" }
                ]
            },
            {
                title: "Extension: Sandbox mode",
                pages: [
                    { title: "Introducing Sandbox mode", url: "modules/Coding_Games_with_Python/iframes/Introducing_Sandbox_mode_4.html" }
                ]
            },
            {
                title: "Section 5: Variables",
                pages: [
                    { title: "Section 5 Introduction", url: "modules/Coding_Games_with_Python/iframes/Section_5_Introduction.html" }
                ]
            },
            {
                title: "Coding Task",
                pages: [
                    { title: "Coding task introduction", url: "modules/Coding_Games_with_Python/iframes/Coding_task_introduction_6.html" }
                ]
            },
            {
                title: "Section 5 Quiz",
                pages: [
                    { title: "Section 5 Quiz", url: "modules/Coding_Games_with_Python/iframes/Section_5_Quiz.html" }
                ]
            },
            {
                title: "Section 5 Reflection",
                pages: [
                    { title: "Section 5 Reflection", url: "modules/Coding_Games_with_Python/iframes/Section_5_Reflection.html" }
                ]
            },
            {
                title: "Section 5 Summary",
                pages: [
                    { title: "Section 5 Summary", url: "modules/Coding_Games_with_Python/iframes/Section_5_Summary.html" }
                ]
            },
            {
                title: "Extension: Sandbox mode",
                pages: [
                    { title: "Introducing Sandbox mode", url: "modules/Coding_Games_with_Python/iframes/Introducing_Sandbox_mode_5.html" }
                ]
            },
            {
                title: "Section 6: Python and AI",
                pages: [
                    { title: "Section 6 Introduction", url: "modules/Coding_Games_with_Python/iframes/Section_6_Introduction.html" },
                    { title: "Basic AI concepts", url: "modules/Coding_Games_with_Python/iframes/Basic_AI_concepts.html" }
                ]
            },
            {
                title: "Coding Task",
                pages: [
                    { title: "Coding task introduction", url: "modules/Coding_Games_with_Python/iframes/Coding_task_introduction_7.html" }
                ]
            },
            {
                title: "Section 6 Quiz",
                pages: [
                    { title: "Section 6 Quiz", url: "modules/Coding_Games_with_Python/iframes/Section_6_Quiz.html" }
                ]
            },
            {
                title: "Section 6 Reflection",
                pages: [
                    { title: "Section 6 Reflection", url: "modules/Coding_Games_with_Python/iframes/Section_6_Reflection.html" }
                ]
            },
            {
                title: "Check your skills again",
                pages: [
                    { title: "Check your skills again", url: "modules/Coding_Games_with_Python/iframes/Check_your_skills_again.html" }
                ]
            },
            {
                title: "Course Summary",
                pages: [
                    { title: "Course Summary", url: "modules/Coding_Games_with_Python/iframes/Course_Summary.html" },
                    { title: "Your Course Certificate", url: "modules/Coding_Games_with_Python/iframes/Your_Course_Certificate.html" }
                ]
            },
            {
                title: "Extension: Sandbox mode",
                pages: [
                    { title: "Introducing Sandbox mode", url: "modules/Coding_Games_with_Python/iframes/Introducing_Sandbox_mode_6.html" }
                ]
            }
        ]
    },
    {
        title: "Creative Problem Solving",
        sections: [
            {
                title: "Getting Started",
                pages: [
                    { title: "😃 Welcome", url: "modules/Creative_Problem_Solving/iframes/Welcome.html" },
                    { title: "📚 All About Your Course", url: "modules/Creative_Problem_Solving/iframes/All_About_Your_Course.html" },
                    { title: "✅ Check your Creative Problem Solving skills", url: "modules/Creative_Problem_Solving/iframes/Check_your_Creative_Problem_Solving_skills.html" }
                ]
            },
            {
                title: "Section 1: Exploring and Investigating",
                pages: [
                    { title: "Course Director's Introduction", url: "modules/Creative_Problem_Solving/iframes/Course_Directors_Introduction.html" },
                    { title: "Word Cloud Task", url: "modules/Creative_Problem_Solving/iframes/Word_Cloud_Task.html" },
                    { title: "Viewing Task", url: "modules/Creative_Problem_Solving/iframes/Viewing_Task.html" },
                    { title: "Interactive Reading Task", url: "modules/Creative_Problem_Solving/iframes/Interactive_Reading_Task.html" },
                    { title: "Practice Task", url: "modules/Creative_Problem_Solving/iframes/Practice_Task.html" },
                    { title: "Review Task", url: "modules/Creative_Problem_Solving/iframes/Review_Task.html" },
                    { title: "Personalisation Task", url: "modules/Creative_Problem_Solving/iframes/Personalisation_Task.html" },
                    { title: "Your Creative Solution", url: "modules/Creative_Problem_Solving/iframes/Your_Creative_Solution.html" },
                    { title: "Reflect on Your Learning", url: "modules/Creative_Problem_Solving/iframes/Reflect_on_Your_Learning.html" },
                    { title: "Course Director's Summary", url: "modules/Creative_Problem_Solving/iframes/Course_Directors_Summary.html" },
                    { title: "Section 1 Student Feedback", url: "modules/Creative_Problem_Solving/iframes/Section_1_Student_Feedback.html" }
                ]
            },
            {
                title: "Section 2: Generating Ideas",
                pages: [
                    { title: "Course Director's Introduction", url: "modules/Creative_Problem_Solving/iframes/Course_Directors_Introduction_2.html" },
                    { title: "Viewing Task 1", url: "modules/Creative_Problem_Solving/iframes/Viewing_Task_1.html" },
                    { title: "Viewing Task 2", url: "modules/Creative_Problem_Solving/iframes/Viewing_Task_2.html" },
                    { title: "Practice Task 1", url: "modules/Creative_Problem_Solving/iframes/Practice_Task_1.html" },
                    { title: "Practice Task 2", url: "modules/Creative_Problem_Solving/iframes/Practice_Task_2.html" },
                    { title: "Viewing Task", url: "modules/Creative_Problem_Solving/iframes/Viewing_Task_3.html" },
                    { title: "Practice Task", url: "modules/Creative_Problem_Solving/iframes/Practice_Task_3.html" },
                    { title: "Review Task", url: "modules/Creative_Problem_Solving/iframes/Review_Task_2.html" },
                    { title: "Your Creative Solution", url: "modules/Creative_Problem_Solving/iframes/Your_Creative_Solution_2.html" },
                    { title: "Reflect on Your Learning", url: "modules/Creative_Problem_Solving/iframes/Reflect_on_Your_Learning_2.html" },
                    { title: "Course Director's Summary", url: "modules/Creative_Problem_Solving/iframes/Course_Directors_Summary_2.html" },
                    { title: "Section 2 Student Feedback", url: "modules/Creative_Problem_Solving/iframes/Section_2_Student_Feedback.html" }
                ]
            },
            {
                title: "Section 3: Crafting and Improving",
                pages: [
                    { title: "Course Director's Introduction", url: "modules/Creative_Problem_Solving/iframes/Course_Directors_Introduction_3.html" },
                    { title: "Viewing Task", url: "modules/Creative_Problem_Solving/iframes/Viewing_Task_4.html" },
                    { title: "Practice Task", url: "modules/Creative_Problem_Solving/iframes/Practice_Task_4.html" },
                    { title: "Listening Task", url: "modules/Creative_Problem_Solving/iframes/Listening_Task.html" },
                    { title: "Interactive Reading Task", url: "modules/Creative_Problem_Solving/iframes/Interactive_Reading_Task_2.html" },
                    { title: "Review Task", url: "modules/Creative_Problem_Solving/iframes/Review_Task_3.html" },
                    { title: "Empathy", url: "modules/Creative_Problem_Solving/iframes/Empathy.html" },
                    { title: "Your Creative Solution", url: "modules/Creative_Problem_Solving/iframes/Your_Creative_Solution_3.html" },
                    { title: "Refining Ideas", url: "modules/Creative_Problem_Solving/iframes/Refining_Ideas.html" },
                    { title: "Course Director's Summary", url: "modules/Creative_Problem_Solving/iframes/Course_Directors_Summary_3.html" },
                    { title: "Section 3 Student Feedback", url: "modules/Creative_Problem_Solving/iframes/Section_3_Student_Feedback.html" }
                ]
            },
            {
                title: "Section 4: Being Persistent",
                pages: [
                    { title: "Course Director's Introduction", url: "modules/Creative_Problem_Solving/iframes/Course_Directors_Introduction_4.html" },
                    { title: "Reflection Task", url: "modules/Creative_Problem_Solving/iframes/Reflection_Task.html" },
                    { title: "Viewing Task", url: "modules/Creative_Problem_Solving/iframes/Viewing_Task_5.html" },
                    { title: "Review Task", url: "modules/Creative_Problem_Solving/iframes/Review_Task_4.html" },
                    { title: "Interactive Reading Task", url: "modules/Creative_Problem_Solving/iframes/Interactive_Reading_Task_3.html" },
                    { title: "Journal Task", url: "modules/Creative_Problem_Solving/iframes/Journal_Task.html" },
                    { title: "Practice Task", url: "modules/Creative_Problem_Solving/iframes/Practice_Task_5.html" },
                    { title: "Your Creative Solution", url: "modules/Creative_Problem_Solving/iframes/Your_Creative_Solution_4.html" },
                    { title: "Reflect on Your Learning", url: "modules/Creative_Problem_Solving/iframes/Reflect_on_Your_Learning_3.html" },
                    { title: "Course Director's Summary", url: "modules/Creative_Problem_Solving/iframes/Course_Directors_Summary_4.html" },
                    { title: "Section 4 Student Feedback", url: "modules/Creative_Problem_Solving/iframes/Section_4_Student_Feedback.html" }
                ]
            },
            {
                title: "Section 5: Sharing Ideas",
                pages: [
                    { title: "Course Director's Introduction", url: "modules/Creative_Problem_Solving/iframes/Course_Directors_Introduction_5.html" },
                    { title: "Viewing Task", url: "modules/Creative_Problem_Solving/iframes/Viewing_Task_6.html" },
                    { title: "Practice Task", url: "modules/Creative_Problem_Solving/iframes/Practice_Task_6.html" },
                    { title: "Interactive Reading Task", url: "modules/Creative_Problem_Solving/iframes/Interactive_Reading_Task_4.html" },
                    { title: "Practice Task 1", url: "modules/Creative_Problem_Solving/iframes/Practice_Task_1_2.html" },
                    { title: "Practice Task 2", url: "modules/Creative_Problem_Solving/iframes/Practice_Task_2_2.html" },
                    { title: "Review Task", url: "modules/Creative_Problem_Solving/iframes/Review_Task_5.html" },
                    { title: "Survey Task", url: "modules/Creative_Problem_Solving/iframes/Survey_Task.html" },
                    { title: "Your Creative Solution", url: "modules/Creative_Problem_Solving/iframes/Your_Creative_Solution_5.html" },
                    { title: "Reflect on Your Learning", url: "modules/Creative_Problem_Solving/iframes/Reflect_on_Your_Learning_4.html" },
                    { title: "Course Director's Summary", url: "modules/Creative_Problem_Solving/iframes/Course_Directors_Summary_5.html" },
                    { title: "Section 5 Student Feedback", url: "modules/Creative_Problem_Solving/iframes/Section_5_Student_Feedback.html" }
                ]
            },
            {
                title: "Section 6: Reflecting Critically",
                pages: [
                    { title: "Course Director's Introduction", url: "modules/Creative_Problem_Solving/iframes/Course_Directors_Introduction_6.html" },
                    { title: "Viewing Task", url: "modules/Creative_Problem_Solving/iframes/Viewing_Task_7.html" },
                    { title: "Review Task", url: "modules/Creative_Problem_Solving/iframes/Review_Task_6.html" },
                    { title: "Your Challenges", url: "modules/Creative_Problem_Solving/iframes/Your_Challenges.html" },
                    { title: "Analysing the Creative Process", url: "modules/Creative_Problem_Solving/iframes/Analysing_the_Creative_Process.html" },
                    { title: "Your Creative Solution", url: "modules/Creative_Problem_Solving/iframes/Your_Creative_Solution_6.html" },
                    { title: "Course Director's Summary", url: "modules/Creative_Problem_Solving/iframes/Course_Directors_Summary_6.html" },
                    { title: "Section 6 Student Feedback", url: "modules/Creative_Problem_Solving/iframes/Section_6_Student_Feedback.html" }
                ]
            },
            {
                title: "End of Course Assessment",
                pages: [
                    { title: "End of Course Assessment", url: "modules/Creative_Problem_Solving/iframes/End_of_Course_Assessment.html" }
                ]
            },
            {
                title: "Summing Up",
                pages: [
                    { title: "Understanding SMART Objectives", url: "modules/Creative_Problem_Solving/iframes/Understanding_SMART_Objectives.html" },
                    { title: "Your Personal Development Plan", url: "modules/Creative_Problem_Solving/iframes/Your_Personal_Development_Plan.html" },
                    { title: "Course Director's Summary", url: "modules/Creative_Problem_Solving/iframes/Course_Directors_Summary_7.html" },
                    { title: "Course Certificate", url: "modules/Creative_Problem_Solving/iframes/Course_Certificate.html" }
                ]
            },
            {
                title: "Journal",
                pages: [
                    { title: "Journal", url: "modules/Creative_Problem_Solving/iframes/Journal.html" }
                ]
            },
            {
                title: "Resources",
                pages: [
                    { title: "Resources", url: "modules/Creative_Problem_Solving/iframes/Resources.html" }
                ]
            }
        ]
    },
    {
        title: "CV Writing",
        sections: [
            {
                title: "Getting Started",
                pages: [
                    { title: "😃 Welcome", url: "modules/CV_Writing/iframes/Welcome.html" },
                    { title: "📚 All About Your Course", url: "modules/CV_Writing/iframes/All_About_Your_Course.html" },
                    { title: "✅ Check your CV Writing skills", url: "modules/CV_Writing/iframes/Check_your_CV_Writing_skills.html" }
                ]
            },
            {
                title: "Section 1: Understanding CVs",
                pages: [
                    { title: "Course Director's Introduction", url: "modules/CV_Writing/iframes/Course_Directors_Introduction.html" },
                    { title: "Viewing Task", url: "modules/CV_Writing/iframes/Viewing_Task.html" },
                    { title: "Reflection Task", url: "modules/CV_Writing/iframes/Reflection_Task.html" },
                    { title: "Interactive Reading Task", url: "modules/CV_Writing/iframes/Interactive_Reading_Task.html" },
                    { title: "Review Task", url: "modules/CV_Writing/iframes/Review_Task.html" },
                    { title: "The Employer's Perspective", url: "modules/CV_Writing/iframes/The_Employers_Perspective.html" },
                    { title: "Reflect on Your Learning", url: "modules/CV_Writing/iframes/Reflect_on_Your_Learning.html" },
                    { title: "End of Section", url: "modules/CV_Writing/iframes/End_of_Section.html" },
                    { title: "Section 1 Student Feedback", url: "modules/CV_Writing/iframes/Section_1_Student_Feedback.html" }
                ]
            },
            {
                title: "Section 2: Starting Your CV",
                pages: [
                    { title: "What's in this Section?", url: "modules/CV_Writing/iframes/Whats_in_this_Section.html" },
                    { title: "Interactive Reading Task", url: "modules/CV_Writing/iframes/Interactive_Reading_Task_2.html" },
                    { title: "Practice Task", url: "modules/CV_Writing/iframes/Practice_Task.html" },
                    { title: "Refining your 'You List'", url: "modules/CV_Writing/iframes/Refining_your_You_List.html" },
                    { title: "Review Task", url: "modules/CV_Writing/iframes/Review_Task_2.html" },
                    { title: "Viewing Task", url: "modules/CV_Writing/iframes/Viewing_Task_2.html" },
                    { title: "Practice Task 1", url: "modules/CV_Writing/iframes/Practice_Task_1.html" },
                    { title: "Practice Task 2", url: "modules/CV_Writing/iframes/Practice_Task_2.html" },
                    { title: "Reflect on Your Learning", url: "modules/CV_Writing/iframes/Reflect_on_Your_Learning_2.html" },
                    { title: "End of Section", url: "modules/CV_Writing/iframes/End_of_Section_2.html" },
                    { title: "Section 2 Student Feedback", url: "modules/CV_Writing/iframes/Section_2_Student_Feedback.html" }
                ]
            },
            {
                title: "Section 3: Ordering and Formatting",
                pages: [
                    { title: "What's in this Section?", url: "modules/CV_Writing/iframes/Whats_in_this_Section_2.html" },
                    { title: "Practice Task (Part 1)", url: "modules/CV_Writing/iframes/Practice_Task_Part_1.html" },
                    { title: "Practice Task (Part 2)", url: "modules/CV_Writing/iframes/Practice_Task_Part_2.html" },
                    { title: "Review Task", url: "modules/CV_Writing/iframes/Review_Task_3.html" },
                    { title: "Interactive Reading Task", url: "modules/CV_Writing/iframes/Interactive_Reading_Task_3.html" },
                    { title: "Reflection Task", url: "modules/CV_Writing/iframes/Reflection_Task_2.html" },
                    { title: "What to Include", url: "modules/CV_Writing/iframes/What_to_Include.html" },
                    { title: "Viewing Task", url: "modules/CV_Writing/iframes/Viewing_Task_3.html" },
                    { title: "Practice Task", url: "modules/CV_Writing/iframes/Practice_Task_3.html" },
                    { title: "Reflect on Your Learning", url: "modules/CV_Writing/iframes/Reflect_on_Your_Learning_3.html" },
                    { title: "End of Section", url: "modules/CV_Writing/iframes/End_of_Section_3.html" },
                    { title: "Section 3 Student Feedback", url: "modules/CV_Writing/iframes/Section_3_Student_Feedback.html" }
                ]
            },
            {
                title: "Section 4: Tailoring Your CV",
                pages: [
                    { title: "What's in this Section?", url: "modules/CV_Writing/iframes/Whats_in_this_Section_3.html" },
                    { title: "Viewing Task", url: "modules/CV_Writing/iframes/Viewing_Task_4.html" },
                    { title: "Practice Task 1", url: "modules/CV_Writing/iframes/Practice_Task_1_2.html" },
                    { title: "Practice Task 2", url: "modules/CV_Writing/iframes/Practice_Task_2_2.html" },
                    { title: "Practice Task", url: "modules/CV_Writing/iframes/Practice_Task_4.html" },
                    { title: "Reflection Task", url: "modules/CV_Writing/iframes/Reflection_Task_3.html" },
                    { title: "Checking Your CV 1", url: "modules/CV_Writing/iframes/Checking_Your_CV_1.html" },
                    { title: "Interactive Reading Task", url: "modules/CV_Writing/iframes/Interactive_Reading_Task_4.html" },
                    { title: "Reflect on Your Learning", url: "modules/CV_Writing/iframes/Reflect_on_Your_Learning_4.html" },
                    { title: "End of Section", url: "modules/CV_Writing/iframes/End_of_Section_4.html" },
                    { title: "Section 4 Student Feedback", url: "modules/CV_Writing/iframes/Section_4_Student_Feedback.html" }
                ]
            },
            {
                title: "Section 5: Writing a Cover Letter",
                pages: [
                    { title: "What's in this Section?", url: "modules/CV_Writing/iframes/Whats_in_this_Section_4.html" },
                    { title: "Viewing Task", url: "modules/CV_Writing/iframes/Viewing_Task_5.html" },
                    { title: "Interactive Reading Task", url: "modules/CV_Writing/iframes/Interactive_Reading_Task_5.html" },
                    { title: "Practice Task (Part 1)", url: "modules/CV_Writing/iframes/Practice_Task_Part_1_2.html" },
                    { title: "Practice Task (Part 3)", url: "modules/CV_Writing/iframes/Practice_Task_Part_3.html" },
                    { title: "Survey Task", url: "modules/CV_Writing/iframes/Survey_Task.html" },
                    { title: "Reflection Task", url: "modules/CV_Writing/iframes/Reflection_Task_4.html" },
                    { title: "Reading Task", url: "modules/CV_Writing/iframes/Reading_Task.html" },
                    { title: "Practice Task", url: "modules/CV_Writing/iframes/Practice_Task_5.html" },
                    { title: "Avoiding Clichés", url: "modules/CV_Writing/iframes/Avoiding_Cliches.html" },
                    { title: "Reflect on Your Learning", url: "modules/CV_Writing/iframes/Reflect_on_Your_Learning_5.html" },
                    { title: "End of Section", url: "modules/CV_Writing/iframes/End_of_Section_5.html" },
                    { title: "Section 5 Student Feedback", url: "modules/CV_Writing/iframes/Section_5_Student_Feedback.html" }
                ]
            },
            {
                title: "Section 6: Advertising Your CV",
                pages: [
                    { title: "What's in this Section?", url: "modules/CV_Writing/iframes/Whats_in_this_Section_5.html" },
                    { title: "Reading Task", url: "modules/CV_Writing/iframes/Reading_Task_2.html" },
                    { title: "Practice Task", url: "modules/CV_Writing/iframes/Practice_Task_6.html" },
                    { title: "Interactive Reading Task", url: "modules/CV_Writing/iframes/Interactive_Reading_Task_6.html" },
                    { title: "Final check of Your CV", url: "modules/CV_Writing/iframes/Final_check_of_Your_CV.html" },
                    { title: "Reflect on Your Learning", url: "modules/CV_Writing/iframes/Reflect_on_Your_Learning_6.html" },
                    { title: "End of Course Assessment Test", url: "modules/CV_Writing/iframes/End_of_Course_Assessment_Test.html" },
                    { title: "Section 6 Student Feedback", url: "modules/CV_Writing/iframes/Section_6_Student_Feedback.html" }
                ]
            }
        ]
    },
    { title: "Entrepreneurship", sections: [] },
    { title: "Job Interview Skills", sections: [] },
    { title: "Making an Impact", sections: [] },
    { title: "Personal Statement Writing", sections: [] },
    { title: "Preparing for BMAT", sections: [] },
    { title: "Preparing for LNAT", sections: [] },
    { title: "Preparing for TSA", sections: [] },
    { title: "Public Speaking", sections: [] },
    { title: "Resilience", sections: [] },
    { title: "Study Skills", sections: [] },
    { title: "University Interview Skills", sections: [] },
    { title: "Verbal Communication", sections: [] },
    { title: "Writing Skills", sections: [] }
]
EOF
)

echo "Directory and file creation complete!"