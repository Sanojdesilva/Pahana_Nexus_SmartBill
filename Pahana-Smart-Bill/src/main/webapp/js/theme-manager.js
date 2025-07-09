// Global Theme Manager - Applied across all pages
class ThemeManager {
    constructor() {
        this.init();
    }
    
    init() {
        this.loadThemeFromServer();
        this.applyTheme();
        this.setupThemeListeners();
        this.createThemeToggle();
    }
    
    // Create theme toggle button
    createThemeToggle() {
        // Check if toggle already exists
        if (document.querySelector('.theme-toggle')) {
            return;
        }
        
        const toggle = document.createElement('div');
        toggle.className = 'theme-toggle';
        toggle.innerHTML = `
            <i class="fas fa-sun sun-icon"></i>
            <i class="fas fa-moon moon-icon"></i>
        `;
        
        // Add click event
        toggle.addEventListener('click', () => {
            this.toggleDarkMode();
            this.updateToggleState();
        });
        
        // Position the toggle based on page type
        const header = document.querySelector('.header');
        const loginContainer = document.querySelector('.login-container');
        
        if (header) {
            // For pages with header, add to header
            const headerContent = header.querySelector('.header-content');
            if (headerContent) {
                // Create new header structure with toggle
                const headerWithToggle = document.createElement('div');
                headerWithToggle.className = 'header-with-toggle';
                
                const headerLeft = document.createElement('div');
                headerLeft.className = 'header-left';
                
                const headerRight = document.createElement('div');
                headerRight.className = 'header-right';
                
                // Move existing content
                const title = headerContent.querySelector('h1');
                const userInfo = headerContent.querySelector('.user-info');
                
                if (title) {
                    headerLeft.appendChild(title.cloneNode(true));
                }
                
                if (userInfo) {
                    headerRight.appendChild(userInfo.cloneNode(true));
                }
                
                headerRight.appendChild(toggle);
                
                headerWithToggle.appendChild(headerLeft);
                headerWithToggle.appendChild(headerRight);
                
                headerContent.innerHTML = '';
                headerContent.appendChild(headerWithToggle);
            }
        } else if (loginContainer) {
            // For login page, add as fixed toggle
            toggle.classList.add('login-theme-toggle');
            document.body.appendChild(toggle);
        } else {
            // Fallback: add to body
            toggle.style.position = 'fixed';
            toggle.style.top = '20px';
            toggle.style.right = '20px';
            toggle.style.zIndex = '1000';
            document.body.appendChild(toggle);
        }
        
        this.updateToggleState();
    }
    
    // Update toggle button state
    updateToggleState() {
        const toggle = document.querySelector('.theme-toggle');
        if (toggle) {
            const isDark = document.body.getAttribute('data-theme') === 'dark';
            toggle.setAttribute('aria-label', isDark ? 'Switch to light mode' : 'Switch to dark mode');
        }
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
                this.updateToggleState();
            }
        });
        
        // Listen for theme changes from settings page
        window.addEventListener('storage', (e) => {
            if (e.key === 'theme' || e.key === 'appTheme' || e.key === 'primaryColor') {
                this.loadThemeFromLocalStorage();
                this.updateToggleState();
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
        
        // Save to server if possible
        this.saveThemeToServer();
    }
    
    // Save theme to server
    async saveThemeToServer() {
        try {
            const isDark = document.body.getAttribute('data-theme') === 'dark';
            const response = await fetch('/admin/settings?action=saveTheme', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    darkMode: isDark.toString(),
                    theme: 'default',
                    primaryColor: getComputedStyle(document.documentElement).getPropertyValue('--primary-color').trim()
                })
            });
            
            if (response.ok) {
                console.log('Theme saved to server');
            }
        } catch (error) {
            console.log('Could not save theme to server');
        }
    }
    
    // Set theme
    setTheme(theme) {
        const body = document.body;
        body.setAttribute('data-theme', theme);
        localStorage.setItem('appTheme', theme);
        this.updateToggleState();
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