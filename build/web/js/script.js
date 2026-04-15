// Basic JavaScript for interactivity
document.addEventListener('DOMContentLoaded', function() {
    // Category filter functionality
    const categoryRadios = document.querySelectorAll('input[name="category"]');
    const templateCards = document.querySelectorAll('.template-card');
    
    categoryRadios.forEach(radio => {
        radio.addEventListener('change', function() {
            // In a real application, this would filter the templates
            console.log('Selected category:', this.value);
            
            // Add visual feedback
            templateCards.forEach(card => {
                card.style.opacity = '0.7';
                setTimeout(() => {
                    card.style.opacity = '1';
                }, 300);
            });
        });
    });
    
    // Sort buttons functionality
    const sortButtons = document.querySelectorAll('.sort-btn');
    
    sortButtons.forEach(button => {
        button.addEventListener('click', function() {
            // Remove active class from all buttons
            sortButtons.forEach(btn => btn.classList.remove('active'));
            // Add active class to clicked button
            this.classList.add('active');
            
            // In a real application, this would sort the templates
            console.log('Sort by:', this.textContent);
            
            // Add visual feedback
            templateCards.forEach(card => {
                card.style.opacity = '0.7';
                setTimeout(() => {
                    card.style.opacity = '1';
                }, 300);
            });
        });
    });
    
    // Template card hover effects
    templateCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-4px)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });
    
    // Button click handlers
    const previewButtons = document.querySelectorAll('.btn-preview');
    const detailButtons = document.querySelectorAll('.btn-detail');
    
    previewButtons.forEach(button => {
        button.addEventListener('click', function() {
            const templateTitle = this.closest('.template-card').querySelector('.template-title').textContent;
            console.log('Preview template:', templateTitle);
            // In a real application, this would open a preview
            alert('Xem thí: ' + templateTitle);
        });
    });
    
    detailButtons.forEach(button => {
        button.addEventListener('click', function() {
            const templateTitle = this.closest('.template-card').querySelector('.template-title').textContent;
            console.log('View details for:', templateTitle);
            // In a real application, this would navigate to details page
            alert('Chi tiêt: ' + templateTitle);
        });
    });
    
    // Search functionality
    const searchInput = document.querySelector('.search-input');
    const searchBtn = document.querySelector('.search-btn');
    
    function performSearch() {
        const searchTerm = searchInput.value.trim();
        if (searchTerm) {
            console.log('Searching for:', searchTerm);
            // In a real application, this would perform actual search
            templateCards.forEach(card => {
                const title = card.querySelector('.template-title').textContent.toLowerCase();
                if (title.includes(searchTerm.toLowerCase())) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        } else {
            templateCards.forEach(card => {
                card.style.display = 'block';
            });
        }
    }
    
    searchBtn.addEventListener('click', performSearch);
    
    searchInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            performSearch();
        }
    });
    
    // Navigation menu interactions
    const navLinks = document.querySelectorAll('.nav-link');
    
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            if (this.getAttribute('href') === '#') {
                e.preventDefault();
                console.log('Navigation clicked:', this.textContent);
            }
        });
    });
});
