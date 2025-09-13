#!/usr/bin/env python3
"""
Assessment Generator for vSphere 8 Training
Generates randomized assessments from question banks
"""

import json
import random
import argparse
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Any

class AssessmentGenerator:
    def __init__(self, question_bank_path: str = "question_banks"):
        self.question_bank_path = Path(question_bank_path)
        self.question_banks = self.load_question_banks()
        
    def load_question_banks(self) -> Dict[str, List[Dict]]:
        """Load all question banks from JSON files"""
        banks = {}
        
        # Sample question bank structure
        sample_questions = {
            "architecture": [
                {
                    "id": "arch_001",
                    "type": "multiple_choice",
                    "question": "What is the maximum number of ESXi hosts supported in a vSphere 8 cluster?",
                    "options": ["32", "64", "96", "128"],
                    "correct_answer": "64",
                    "explanation": "vSphere 8 supports up to 64 ESXi hosts per cluster",
                    "difficulty": "medium",
                    "module": "introduction"
                },
                {
                    "id": "arch_002", 
                    "type": "true_false",
                    "question": "vSphere 8 requires TPM 2.0 for secure boot functionality",
                    "correct_answer": True,
                    "explanation": "TPM 2.0 is required for enhanced security features in vSphere 8",
                    "difficulty": "easy",
                    "module": "security"
                }
            ],
            "storage": [
                {
                    "id": "stor_001",
                    "type": "multiple_choice", 
                    "question": "Which storage protocol provides the lowest latency for vSAN?",
                    "options": ["iSCSI", "NFS", "NVMe over Fabrics", "Fibre Channel"],
                    "correct_answer": "NVMe over Fabrics",
                    "explanation": "NVMe over Fabrics provides the lowest latency storage access",
                    "difficulty": "hard",
                    "module": "storage-management"
                }
            ],
            "networking": [
                {
                    "id": "net_001",
                    "type": "short_answer",
                    "question": "What command would you use to configure NTP on an ESXi host via CLI?",
                    "correct_answer": "esxcli system ntp set --server",
                    "explanation": "The esxcli system ntp set command configures NTP servers",
                    "difficulty": "medium", 
                    "module": "networking"
                }
            ]
        }
        
        return sample_questions
    
    def generate_assessment(self, 
                          assessment_type: str = "module",
                          modules: List[str] = None,
                          num_questions: int = 20,
                          difficulty_mix: Dict[str, float] = None) -> Dict[str, Any]:
        """Generate a randomized assessment"""
        
        if difficulty_mix is None:
            difficulty_mix = {"easy": 0.3, "medium": 0.5, "hard": 0.2}
            
        if modules is None:
            modules = ["introduction", "esxi-deployment", "storage-management"]
            
        # Calculate questions per difficulty level
        questions_per_difficulty = {
            level: int(num_questions * ratio) 
            for level, ratio in difficulty_mix.items()
        }
        
        # Ensure total adds up to num_questions
        total_allocated = sum(questions_per_difficulty.values())
        if total_allocated < num_questions:
            questions_per_difficulty["medium"] += num_questions - total_allocated
            
        selected_questions = []
        
        # Collect all relevant questions
        all_questions = []
        for bank_name, questions in self.question_banks.items():
            for question in questions:
                if question.get("module") in modules:
                    all_questions.append(question)
        
        # Select questions by difficulty
        for difficulty, count in questions_per_difficulty.items():
            difficulty_questions = [q for q in all_questions if q.get("difficulty") == difficulty]
            selected = random.sample(difficulty_questions, min(count, len(difficulty_questions)))
            selected_questions.extend(selected)
        
        # Shuffle final question order
        random.shuffle(selected_questions)
        
        # Generate assessment metadata
        assessment = {
            "id": f"assessment_{datetime.now().strftime('%Y%m%d_%H%M%S')}",
            "type": assessment_type,
            "title": f"vSphere 8 {assessment_type.title()} Assessment",
            "modules": modules,
            "created_date": datetime.now().isoformat(),
            "duration_minutes": self.calculate_duration(selected_questions),
            "total_questions": len(selected_questions),
            "difficulty_distribution": questions_per_difficulty,
            "questions": selected_questions,
            "instructions": self.generate_instructions(assessment_type),
            "grading_rubric": self.generate_grading_rubric()
        }
        
        return assessment
    
    def calculate_duration(self, questions: List[Dict]) -> int:
        """Calculate estimated assessment duration"""
        time_per_type = {
            "multiple_choice": 1.5,
            "true_false": 1.0,
            "short_answer": 3.0,
            "essay": 10.0,
            "scenario": 15.0
        }
        
        total_minutes = sum(
            time_per_type.get(q.get("type", "multiple_choice"), 2.0) 
            for q in questions
        )
        
        return int(total_minutes) + 10  # Add 10 minutes buffer
    
    def generate_instructions(self, assessment_type: str) -> List[str]:
        """Generate assessment instructions"""
        base_instructions = [
            "Read each question carefully before answering",
            "Select the best answer for multiple choice questions", 
            "Provide clear, concise answers for short answer questions",
            "Manage your time effectively throughout the assessment"
        ]
        
        type_specific = {
            "module": [
                "This assessment covers material from the specified training modules",
                "You may refer to your notes and lab guides"
            ],
            "final": [
                "This is a comprehensive assessment covering all course material",
                "No external resources are permitted during this assessment",
                "Ensure all answers are your own work"
            ],
            "practice": [
                "This is a practice assessment to help you prepare",
                "Take your time and review explanations after completion"
            ]
        }
        
        return base_instructions + type_specific.get(assessment_type, [])
    
    def generate_grading_rubric(self) -> Dict[str, Any]:
        """Generate grading rubric"""
        return {
            "grading_scale": {
                "A": {"min": 90, "max": 100, "description": "Excellent understanding"},
                "B": {"min": 80, "max": 89, "description": "Good understanding"}, 
                "C": {"min": 70, "max": 79, "description": "Satisfactory understanding"},
                "D": {"min": 60, "max": 69, "description": "Below expectations"},
                "F": {"min": 0, "max": 59, "description": "Inadequate understanding"}
            },
            "question_weights": {
                "multiple_choice": 1.0,
                "true_false": 0.5,
                "short_answer": 2.0,
                "essay": 5.0,
                "scenario": 10.0
            },
            "passing_score": 70,
            "retake_policy": "One retake allowed within 48 hours"
        }
    
    def export_assessment(self, assessment: Dict[str, Any], format: str = "json") -> str:
        """Export assessment to specified format"""
        timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
        filename = f"assessment_{assessment['type']}_{timestamp}"
        
        if format == "json":
            filepath = f"{filename}.json"
            with open(filepath, 'w') as f:
                json.dump(assessment, f, indent=2)
                
        elif format == "html":
            filepath = f"{filename}.html"
            html_content = self.generate_html_assessment(assessment)
            with open(filepath, 'w') as f:
                f.write(html_content)
                
        return filepath
    
    def generate_html_assessment(self, assessment: Dict[str, Any]) -> str:
        """Generate HTML version of assessment"""
        html = f"""
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{assessment['title']}</title>
    <style>
        body {{ font-family: Arial, sans-serif; max-width: 800px; margin: 0 auto; padding: 20px; }}
        .header {{ background: #0078d4; color: white; padding: 20px; border-radius: 5px; }}
        .question {{ margin: 20px 0; padding: 15px; border: 1px solid #ddd; border-radius: 5px; }}
        .options {{ margin: 10px 0; }}
        .option {{ margin: 5px 0; }}
        input[type="radio"], input[type="checkbox"] {{ margin-right: 10px; }}
        .instructions {{ background: #f8f9fa; padding: 15px; border-radius: 5px; margin: 20px 0; }}
    </style>
</head>
<body>
    <div class="header">
        <h1>{assessment['title']}</h1>
        <p>Duration: {assessment['duration_minutes']} minutes | Questions: {assessment['total_questions']}</p>
    </div>
    
    <div class="instructions">
        <h3>Instructions:</h3>
        <ul>
"""
        
        for instruction in assessment['instructions']:
            html += f"<li>{instruction}</li>\n"
            
        html += """
        </ul>
    </div>
    
    <form id="assessmentForm">
"""
        
        for i, question in enumerate(assessment['questions'], 1):
            html += f"""
    <div class="question">
        <h3>Question {i}</h3>
        <p><strong>{question['question']}</strong></p>
"""
            
            if question['type'] == 'multiple_choice':
                html += '<div class="options">\n'
                for j, option in enumerate(question['options']):
                    html += f'''
        <div class="option">
            <input type="radio" name="q{i}" value="{option}" id="q{i}_{j}">
            <label for="q{i}_{j}">{option}</label>
        </div>
'''
                html += '</div>\n'
                
            elif question['type'] == 'true_false':
                html += '''
        <div class="options">
            <div class="option">
                <input type="radio" name="q{}" value="true" id="q{}_true">
                <label for="q{}_true">True</label>
            </div>
            <div class="option">
                <input type="radio" name="q{}" value="false" id="q{}_false">
                <label for="q{}_false">False</label>
            </div>
        </div>
'''.format(i, i, i, i, i)
                
            elif question['type'] == 'short_answer':
                html += f'<textarea name="q{i}" rows="3" cols="50" placeholder="Enter your answer here..."></textarea>\n'
                
            html += '    </div>\n'
            
        html += """
    </form>
    
    <script>
        // Add JavaScript for form handling and validation
        document.getElementById('assessmentForm').addEventListener('submit', function(e) {
            e.preventDefault();
            alert('Assessment submitted successfully!');
        });
    </script>
</body>
</html>
"""
        return html

def main():
    parser = argparse.ArgumentParser(description='Generate vSphere 8 training assessments')
    parser.add_argument('--type', choices=['module', 'final', 'practice'], default='module',
                       help='Type of assessment to generate')
    parser.add_argument('--modules', nargs='+', 
                       default=['introduction', 'esxi-deployment'],
                       help='Modules to include in assessment')
    parser.add_argument('--questions', type=int, default=20,
                       help='Number of questions to generate')
    parser.add_argument('--format', choices=['json', 'html'], default='json',
                       help='Output format')
    parser.add_argument('--output', help='Output filename')
    
    args = parser.parse_args()
    
    generator = AssessmentGenerator()
    assessment = generator.generate_assessment(
        assessment_type=args.type,
        modules=args.modules,
        num_questions=args.questions
    )
    
    if args.output:
        filepath = args.output
        if args.format == 'json':
            with open(filepath, 'w') as f:
                json.dump(assessment, f, indent=2)
        elif args.format == 'html':
            html_content = generator.generate_html_assessment(assessment)
            with open(filepath, 'w') as f:
                f.write(html_content)
    else:
        filepath = generator.export_assessment(assessment, args.format)
    
    print(f"Assessment generated: {filepath}")
    print(f"Type: {assessment['type']}")
    print(f"Questions: {assessment['total_questions']}")
    print(f"Duration: {assessment['duration_minutes']} minutes")

if __name__ == "__main__":
    main()