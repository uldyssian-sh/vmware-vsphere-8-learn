/**
 * Training Progress Tracker for vSphere 8 Course
 * Tracks student progress through modules and labs
 */

class TrainingProgressTracker {
    constructor() {
        this.modules = [
            'introduction', 'esxi-deployment', 'vcenter-services', 
            'storage-management', 'networking', 'resource-management',
            'security', 'lifecycle', 'monitoring', 'automation'
        ];
        this.progress = this.loadProgress();
        this.initializeUI();
    }

    loadProgress() {
        const saved = localStorage.getItem('vsphere8-progress');
        return saved ? JSON.parse(saved) : {
            modules: {},
            labs: {},
            assessments: {},
            startDate: new Date().toISOString(),
            lastUpdate: new Date().toISOString()
        };
    }

    saveProgress() {
        this.progress.lastUpdate = new Date().toISOString();
        localStorage.setItem('vsphere8-progress', JSON.stringify(this.progress));
    }

    markModuleComplete(moduleId) {
        this.progress.modules[moduleId] = {
            completed: true,
            completedDate: new Date().toISOString(),
            timeSpent: this.calculateTimeSpent(moduleId)
        };
        this.saveProgress();
        this.updateProgressBar();
        this.showCompletionNotification(moduleId);
    }

    updateProgressBar() {
        const completedModules = Object.keys(this.progress.modules).length;
        const completedLabs = Object.keys(this.progress.labs).length;
        const totalModules = this.modules.length;
        const estimatedLabs = 15;

        const moduleProgress = (completedModules / totalModules) * 100;
        const labProgress = (completedLabs / estimatedLabs) * 100;
        const overallProgress = (moduleProgress + labProgress) / 2;

        this.updateProgressElement('overall-progress', overallProgress);
    }

    updateProgressElement(elementId, percentage) {
        const element = document.getElementById(elementId);
        if (element) {
            element.style.width = percentage + '%';
        }
    }

    calculateTimeSpent(moduleId) {
        const estimatedTimes = {
            'introduction': 120, 'esxi-deployment': 180, 'vcenter-services': 150,
            'storage-management': 200, 'networking': 180, 'resource-management': 220,
            'security': 160, 'lifecycle': 140, 'monitoring': 180, 'automation': 200
        };
        return estimatedTimes[moduleId] || 120;
    }

    showCompletionNotification(moduleId) {
        console.log(`Module ${moduleId} completed!`);
    }

    initializeUI() {
        setTimeout(() => this.updateProgressBar(), 100);
    }
}

document.addEventListener('DOMContentLoaded', () => {
    window.progressTracker = new TrainingProgressTracker();
});