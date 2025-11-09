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
        if (saved) {
            try {
                return JSON.parse(saved);
            } catch (error) {
                console.warn('Invalid progress data in localStorage, resetting:', error);
                localStorage.removeItem('vsphere8-progress');
            }
        }
        return {
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
        const estimatedLabs = this.constructor.ESTIMATED_LABS || 15;

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
        // Create and show notification
        const notification = document.createElement('div');
        notification.className = 'completion-notification';
        notification.innerHTML = `
            <div class="notification-content">
                <h4>🎉 Congratulations!</h4>
                <p>You completed module: ${moduleId}</p>
                <button onclick="this.parentElement.parentElement.remove()">Close</button>
            </div>
        `;
        notification.style.cssText = `
            position: fixed; top: 20px; right: 20px; z-index: 1000;
            background: #28a745; color: white; padding: 15px;
            border-radius: 5px; box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        `;
        document.body.appendChild(notification);
        
        // Auto-remove after 5 seconds
        setTimeout(() => {
            if (notification.parentElement) {
                notification.remove();
            }
        }, 5000);
    }

    initializeUI() {
        // Use proper DOM ready check instead of arbitrary timeout
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', () => this.updateProgressBar());
        } else {
            this.updateProgressBar();
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    window.progressTracker = new TrainingProgressTracker();
});# Updated Sun Nov  9 12:49:17 CET 2025
# Updated Sun Nov  9 12:52:43 CET 2025
