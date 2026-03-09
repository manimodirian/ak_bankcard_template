/*
 * ============================================
 * AK BANK ATM SYSTEM - JAVASCRIPT LOGIC
 * ============================================
 * 
 * TODO: Implement all JavaScript functionality for:
 * - PIN entry system
 * - NUI message handling
 * - Bank menu interactions
 * - Transaction processing
 */

// ============================================
// PIN ENTRY SYSTEM
// TODO: Implement PIN input logic
// ============================================

let currentPin = '';
let correctPin = '';

// TODO: Function to add digit to PIN
// function addPin(digit) {
//     -- Add digit to currentPin
//     -- Update PIN display dots
//     -- Check if PIN is complete (4 digits)
//     -- If complete, verify PIN
// }

// TODO: Function to clear PIN
// function clearPin() {
//     -- Clear currentPin variable
//     -- Clear PIN display dots
// }

// TODO: Function to verify PIN
// function verifyPin() {
//     -- Compare currentPin with correctPin
//     -- If correct, send success callback to FiveM
//     -- If wrong, show error and clear
// }

// TODO: Function to close UI
// function closeUI() {
//     -- Send close callback to FiveM
//     -- Hide all UI elements
//     -- Reset variables
// }


// ============================================
// NUI MESSAGE HANDLING
// TODO: Setup window.addEventListener for 'message'
// ============================================

// window.addEventListener('message', function(event) {
//     let data = event.data;
//     
//     // TODO: Handle PIN screen opening
//     if (data.type === 'openPin') {
//         -- correctPin = data.pin
//         -- Show PIN screen
//         -- Hide bank screen
//         -- Reset PIN input
//     }
//     
//     // TODO: Handle bank menu opening
//     if (data.type === 'openBank') {
//         -- Hide PIN screen
//         -- Show bank screen
//         -- Display player name
//         -- Display IBAN
//         -- Display balance
//     }
// });


// ============================================
// BANK MENU OPERATIONS
// TODO: Implement transaction functions
// ============================================

// TODO: Function for deposit operation
// function deposit() {
//     -- Show amount input
//     -- Get amount from user
//     -- Send to server
//     -- Update balance
// }

// TODO: Function for withdraw operation
// function withdraw() {
//     -- Show amount input
//     -- Get amount from user
//     -- Send to server
//     -- Update balance
// }

// TODO: Function to process transaction
// function processTransaction(action, amount) {
//     -- Validate amount
//     -- Send request to server
//     -- Handle response
//     -- Update UI with new balance
//     -- Show confirmation message
// }


// ============================================
// NUI CALLBACKS
// TODO: Setup callbacks to send data back to FiveM
// ============================================

// TODO: Example NUI callback
// $.post('https://' + GetParentResourceName() + '/pinSuccess', JSON.stringify({}), function(data) {
//     console.log('PIN verified');
// });

// TODO: Create callbacks for all operations:
// - pinSuccess: When PIN is correct
// - pinError: When PIN is wrong
// - doAction: When transaction is initiated
// - close: When closing the UI


// ============================================
// HELPER FUNCTIONS
// TODO: Add utility functions
// ============================================

// TODO: Function to get resource name
// function GetParentResourceName() {
//     -- Return the current resource name
// }

// TODO: Function to format currency
// function formatMoney(amount) {
//     -- Format number as currency
//     -- Add $ or currency symbol
// }

// TODO: Function to hide all screens
// function hideAllScreens() {
//     -- Hide PIN wrapper
//     -- Hide bank wrapper
// }

// TODO: Function to show notifications
// function showNotification(message, type) {
//     -- Display notification to user
//     -- Support different notification types
// }


// ============================================
// DOM INTERACTIONS
// TODO: Setup button click handlers and events
// ============================================

// TODO: Add event listeners for all buttons
// TODO: Add input validation
// TODO: Add keyboard support (optional)
// TODO: Add numeric keypad support (optional)
