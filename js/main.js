// EHS Portal JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Add hover effect to cards
    const cards = document.querySelectorAll('.card');
    
    cards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-10px)';
            this.style.boxShadow = '0 15px 30px rgba(0, 0, 0, 0.15)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
            this.style.boxShadow = '0 4px 8px rgba(0, 0, 0, 0.1)';
        });
        
        // Log clicks for analytics
        card.addEventListener('click', function() {
            const cardTitle = this.querySelector('.card-title').textContent;
            console.log(`Card clicked: ${cardTitle}`);
            // In a real application, you might send this to an analytics service
        });
    });

    // Get current year for footer copyright
    const currentYear = new Date().getFullYear();
    const copyrightElement = document.querySelector('.footer-bottom p');
    if (copyrightElement) {
        copyrightElement.textContent = copyrightElement.textContent.replace('2023', currentYear);
    }
}); 