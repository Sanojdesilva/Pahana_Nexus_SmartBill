// Global Theme Manager - Applied across all pages
class ThemeManager {
    constructor() {
        this.init();
    }
    
    init() {
        this.loadThemeFromServer();
        this.applyTheme();
        this.setupThemeListeners();
    }
    
    // Load theme settings from server
    async loadThemeFromServer() {
        try {
            const response = await fetch('/admin/settings?action=getTheme');
            if (response.ok) {
                const settings = await response.json();
                this.applyServerSettings(settings);
            }
        } catch (error) {
            console.log('Could not load server settings, using local storage');
            this.loadThemeFromLocalStorage();
        }
    }
    
    // Apply settings from server
    applyServerSettings(settings) {
        const body = document.body;
        
        // Apply dark mode
        if (settings.darkMode === 'true') {
            body.setAttribute('data-theme', 'dark');
        } else {
            body.removeAttribute('data-theme');
        }
        
        // Apply theme
        if (settings.theme && settings.theme !== 'default') {
            body.setAttribute('data-theme', settings.theme);
        }
        
        // Apply primary color
        if (settings.primaryColor) {
            document.documentElement.style.setProperty('--primary-color', settings.primaryColor);
        }
        
        // Store in localStorage for consistency
        localStorage.setItem('theme', settings.darkMode === 'true' ? 'dark' : 'light');
        localStorage.setItem('appTheme', settings.theme || 'default');
        localStorage.setItem('primaryColor', settings.primaryColor || '#667eea');
    }
    
    // Load theme from localStorage as fallback
    loadThemeFromLocalStorage() {
        const savedTheme = localStorage.getItem('theme');
        const savedAppTheme = localStorage.getItem('appTheme');
        const savedPrimaryColor = localStorage.getItem('primaryColor');
        
        if (savedTheme === 'dark') {
            document.body.setAttribute('data-theme', 'dark');
        }
        
        if (savedAppTheme && savedAppTheme !== 'default') {
            document.body.setAttribute('data-theme', savedAppTheme);
        }
        
        if (savedPrimaryColor) {
            document.documentElement.style.setProperty('--primary-color', savedPrimaryColor);
        }
    }
    
    // Apply theme to current page
    applyTheme() {
        const body = document.body;
        
        // Check for dark mode preference
        const prefersDark = window.matchMedia('(prefers-color-scheme: dark)').matches;
        const savedTheme = localStorage.getItem('theme');
        
        if (savedTheme === 'dark' || (savedTheme === null && prefersDark)) {
            body.setAttribute('data-theme', 'dark');
        }
    }
    
    // Setup theme change listeners
    setupThemeListeners() {
        // Listen for system theme changes
        window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
            if (!localStorage.getItem('theme')) {
                document.body.setAttribute('data-theme', e.matches ? 'dark' : 'light');
            }
        });
        
        // Listen for theme changes from settings page
        window.addEventListener('storage', (e) => {
            if (e.key === 'theme' || e.key === 'appTheme' || e.key === 'primaryColor') {
                this.loadThemeFromLocalStorage();
            }
        });
    }
    
    // Toggle dark mode
    toggleDarkMode() {
        const body = document.body;
        const isDark = body.getAttribute('data-theme') === 'dark';
        
        if (isDark) {
            body.removeAttribute('data-theme');
            localStorage.setItem('theme', 'light');
        } else {
            body.setAttribute('data-theme', 'dark');
            localStorage.setItem('theme', 'dark');
        }
    }
    
    // Set theme
    setTheme(theme) {
        const body = document.body;
        body.setAttribute('data-theme', theme);
        localStorage.setItem('appTheme', theme);
    }
    
    // Set primary color
    setPrimaryColor(color) {
        document.documentElement.style.setProperty('--primary-color', color);
        localStorage.setItem('primaryColor', color);
    }
}

// Initialize theme manager when DOM is loaded
document.addEventListener('DOMContentLoaded', () => {
    window.themeManager = new ThemeManager();
});

// Export for use in other scripts
if (typeof module !== 'undefined' && module.exports) {
    module.exports = ThemeManager;
} 