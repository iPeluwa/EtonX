const activities = [
    { name: "😃 Welcome", url: "#" },
    { name: "📚 All About Your Course", url: "All_About_Your_Course.html" },
    { name: "⚡️ A snapshot in time", url: "#" },
    { name: "✅ Check your AI skills", url: "#" },
    { name: "Section 1 Introduction", url: "#" },
    { name: "AI in everyday life", url: "#" },
    { name: "What is intelligence?", url: "#" },
    { name: "Activity: What is intelligence?", url: "#" },
    { name: "Activity: A scale of intelligence", url: "#" },
    { name: "A brief history lesson", url: "#" },
    { name: "The AI effect", url: "#" },
    { name: "Section 1 Quiz", url: "#" },
    { name: "Section 1 Reflection", url: "#" },
    { name: "Section 2 Introduction", url: "#" },
    { name: "What are algorithms?", url: "#" },
    { name: "Classical (symbolic) AIs", url: "#" },
    { name: "Taking inspiration from nature", url: "#" },
    { name: "Neural networks fundamentals", url: "#" },
    { name: "The main types of neural networks", url: "#" },
    { name: "Neural Networks Drag and Drop", url: "#" },
    { name: "Machine learning", url: "#" },
    { name: "Section 2 Quiz", url: "#" },
    { name: "Section 2 Reflection", url: "#" },
    { name: "Section 3 Introduction", url: "#" },
    { name: "Large language models (LLMs)", url: "#" },
    { name: "The big three of '23", url: "#" },
    { name: "Hallucinations", url: "#" },
    { name: "Connected conversational AIs", url: "#" },
    { name: "The bootstrap problem", url: "#" },
    { name: "Section 3 Quiz", url: "#" },
    { name: "Section 3 Reflection", url: "#" },
    { name: "Section 4 Introduction", url: "#" },
    { name: "Detail and refinement", url: "#" },
    { name: "Simulation and simulacra", url: "#" },
    { name: "Activity: Simulation and simulacra", url: "#" },
    { name: "Who, when, with, what, why?", url: "#" },
    { name: "Prompts for learning", url: "#" },
    { name: "Image generation", url: "#" },
    { name: "What else can an AI generate?", url: "#" },
    { name: "Section 4 Quiz", url: "#" },
    { name: "Section 4 Reflection", url: "#" },
    { name: "Section 5 Introduction", url: "#" },
    { name: "Inclusion and accessibility", url: "#" },
    { name: "Healthcare, finance and cybersecurity", url: "#" },
    { name: "Bias", url: "#" },
    { name: "Ethics and Alignment", url: "#" },
    { name: "Fake news and deepfakes", url: "#" },
    { name: "Safety and responsibility", url: "#" },
    { name: "Section 5 Quiz", url: "#" },
    { name: "Section 5 Reflection", url: "#" },
    { name: "Section 6 Introduction", url: "#" },
    { name: "Where are we on the sigmoid curve?", url: "#" },
    { name: "Jobs and intellectual property", url: "#" },
    { name: "Artificial general intelligence (AGI)", url: "#" },
    { name: "Existential threat!?", url: "#" },
    { name: "It all comes down to this...", url: "#" },
    { name: "Section 6 Quiz", url: "#" },
    { name: "Section 6 Reflection", url: "#" }
];

// Initialize currentActivityIndex based on the current page's URL
let currentActivityIndex = 0;
const currentPath = window.location.pathname.split('/').pop() || '';
const matchedActivity = activities.findIndex(activity => activity.url === currentPath);
if (matchedActivity !== -1) {
    currentActivityIndex = matchedActivity;
}

const currentActivitySpan = document.getElementById("current-activity");
const nextActivityBtn = document.getElementById("next-activity-btn");
const prevActivityBtn = document.getElementById("prev-activity-btn");

function updateUI() {
    if (currentActivityIndex >= 0 && currentActivityIndex < activities.length) {
        if (currentActivitySpan) {
            currentActivitySpan.textContent = activities[currentActivityIndex].name;
        }
        if (prevActivityBtn) {
            prevActivityBtn.disabled = currentActivityIndex === 0;
        }
        if (nextActivityBtn) {
            nextActivityBtn.disabled = currentActivityIndex === activities.length - 1;
        }
    }
}

function navigateToActivity(index) {
    if (index >= 0 && index < activities.length) {
        const url = activities[index].url;
        if (url !== "#") {
            window.location.href = url;
        } else {
            console.warn(`No valid URL for activity: ${activities[index].name}`);
        }
    }
}

if (nextActivityBtn) {
    nextActivityBtn.addEventListener("click", () => {
        if (currentActivityIndex < activities.length - 1) {
            currentActivityIndex++;
            updateUI();
            navigateToActivity(currentActivityIndex);
        }
    });
}

if (prevActivityBtn) {
    prevActivityBtn.addEventListener("click", () => {
        if (currentActivityIndex > 0) {
            currentActivityIndex--;
            updateUI();
            navigateToActivity(currentActivityIndex);
        }
    });
}

// Initialize the UI
if (currentActivitySpan && prevActivityBtn && nextActivityBtn) {
    updateUI();
} else {
    console.error("Required HTML elements (current-activity, next-activity-btn, prev-activity-btn) not found.");
}