// Theydon Bodyworks - Main JavaScript
// WhatsApp Quote Form Integration

let currentQuoteForm = null;

/**
 * Open a WhatsApp quote form with pre-filled data
 * @param {string} vehicleType - Type of vehicle
 * @param {string} serviceType - Service needed
 * @param {string} message - Additional details
 */
function openQuoteForm(vehicleType, serviceType, message = "") {
    document.getElementById('whatsappQuoteForm').action = `https://api.whatsapp.com/send?text=${encodeURIComponent(`Theydon Bodyworks Quote Request\n\nVehicle: ${vehicleType}\nService: ${serviceType}\nNotes: ${message}`)}`;
    
    // Find and update the form elements in the modal
    const selectElements = document.querySelectorAll('#whatsappQuoteForm select');
    const textarea = document.getElementById('message');
    
    if (selectElements[0] && selectElements[1]) {
        selectElements[0].value = vehicleType || "";
        selectElements[1].value = serviceType || "";
    }
    if (textarea) {
        textarea.value = message;
    }
}

/**
 * Get a quote via WhatsApp by submitting the form
 */
function getQuote(vehicleType, serviceType, message = "") {
    openQuoteForm(vehicleType, serviceType, message);
    
    // Open WhatsApp in new tab and close this modal
    const whatsappUrl = `https://api.whatsapp.com/send?text=${encodeURIComponent(`Theydon Bodyworks Quote Request\n\nVehicle: ${vehicleType}\nService: ${serviceType}\nNotes: ${message}`)}`;
    window.open(whatsappUrl, '_blank');
}

/**
 * Submit the WhatsApp quote form programmatically
 */
function submitQuoteForm() {
    const formData = {
        vehicleType: document.getElementById('vehicleType').value || "Not specified",
        serviceType: document.getElementById('serviceType').value || "Not specified",
        message: document.getElementById('message').value || ""
    };
    
    // Open WhatsApp with pre-filled form data
    const whatsappUrl = `https://api.whatsapp.com/send?text=${encodeURIComponent(`Theydon Bodyworks Quote Request\n\nVehicle: ${formData.vehicleType}\nService: ${formData.serviceType}\nNotes: ${formData.message}`)}`;
    window.open(whatsappUrl, '_blank');
}

// Close modal functionality
document.querySelector('.close-btn').addEventListener('click', function() {
    document.getElementById('quoteForm').style.display = 'none';
});

window.addEventListener('load', function() {
    // Check for any query parameters in URL
    const params = new URLSearchParams(window.location.search);
    const vehicle = params.get('vehicle');
    const service = params.get('service');
    const message = params.get('message');
    
    if (vehicle && service) {
        document.querySelector('#whatsappQuoteForm').action = `https://api.whatsapp.com/send?text=${encodeURIComponent(`Theydon Bodyworks Quote Request\n\nVehicle: ${vehicle}\nService: ${service}\nNotes: ${message || ''}`)}`;
        openQuoteForm(vehicle, service, message);
    }
    
    // Pre-fill quote form with URL params if they exist
    const preFillData = {
        vehicleType: vehicle || document.getElementById('vehicleType').value,
        serviceType: service || document.getElementById('serviceType').value
    };
    
    if (preFillData.vehicleType && preFillData.serviceType) {
        openQuoteForm(preFillData.vehicleType, preFillData.serviceType);
    }
});

// Form submission handler
document.getElementById('whatsappQuoteForm').addEventListener('submit', function(e) {
    e.preventDefault();
    
    const formData = {
        vehicleType: document.getElementById('vehicleType').value || "Not specified",
        serviceType: document.getElementById('serviceType').value || "Not specified",
        message: document.getElementById('message').value
    };
    
    // Get the WhatsApp API URL from form action
    const whatsappUrl = this.action;
    
    // Open WhatsApp in new tab and close this modal
    window.open(whatsappUrl, '_blank');
});
