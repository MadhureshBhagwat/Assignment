import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.validateForm();
    const inputFields = document.querySelectorAll('input[data-controller^="personal-data"]');
    inputFields.forEach(inputField => {
      inputField.addEventListener('input', () => {
        this.validateForm();
      });
    });
  }

  validateForm() {
    const first_name_error = document.getElementById('first_name_error').textContent;
    const last_name_error = document.getElementById('last_name_error').textContent;
    const emailError = document.getElementById('emailError').textContent;
    const phoneNumberError = document.getElementById('phoneNumberError').textContent;
    const firstName = document.getElementById('firstName').value;
    const lastName = document.getElementById('lastName').value;
    const email = document.getElementById('email').value;
    const phone_number = document.getElementById('phone_number').value;

    const saveButton = document.getElementById('saveButton');

    if (first_name_error || last_name_error || emailError || phoneNumberError || firstName === '' || lastName === '' || email === '' || phone_number === '') {
      saveButton.classList.remove('bg-blue-600');
      saveButton.classList.add('bg-gray-400');
      saveButton.disabled = true;
    } else {
      saveButton.classList.remove('bg-gray-400');
      saveButton.classList.add('bg-blue-600');
      saveButton.disabled = false;
    }
  }

  validateName(e) {
    const inputElement = e.target;
    const maxLength = parseInt(inputElement.getAttribute("data-maxlength"), 10);
    const name = inputElement.getAttribute("data-name");
    const errorElement = document.getElementById(inputElement.getAttribute("data-error"));
    const nameRegex = /^[A-Za-z]+$/;

    if (inputElement.value.length === 0) {
      errorElement.innerHTML = '';
    } else if (!nameRegex.test(inputElement.value)) {
      errorElement.innerHTML = `${name} should only contain characters`;
    } else if (inputElement.value.length > maxLength) {
      errorElement.innerHTML = `${name} should not exceed ${maxLength} characters`;
    } else {
      errorElement.innerHTML = '';
    }
  }

  validateEmail(event) {
    const emailValue = event.target.value;
    const email = document.getElementById("email");
    const emailError = document.getElementById('emailError');

    if (this.isValidEmail(emailValue) || emailValue == '') {
      emailError.innerHTML = '';
    } else {
      emailError.innerHTML = 'Please enter a valid email address';
    }
  }

  isValidEmail(email) {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
  }

  validatePhoneNumber(event) {
    let phone_number_value = event.target.value.replace(/[^\d]/g, "");
    const phone_number_element = document.getElementById("phone_number");
    const phone_number_error = document.getElementById("phoneNumberError");
    phone_number_error.innerHTML = '';

    if (phone_number_value.length > 10) {
      phone_number_value = phone_number_value.slice(0, 10);
    }

    if (phone_number_value.length === 10) {
      phone_number_value = `${phone_number_value.slice(0, 3)}-${phone_number_value.slice(3, 6)}-${phone_number_value.slice(6)}`;
      phone_number_element.value = phone_number_value;
      phone_number_error.innerHTML = '';
    } else if ((phone_number_value.length < 10 || phone_number_value.length > 0) && /^\d+$/.test(phone_number_value)) {
      phone_number_error.innerHTML = 'Please enter a 10-digit phone number';
    } else if (!/^\d+$/.test(phone_number_value) && (phone_number_element.value).length > 0) {
      phone_number_error.innerHTML = 'Please enter only integer digit';
    } else if ((phone_number_value.length === 0) || (phone_number_element.value).length === 0) {
      phone_number_error.innerHTML = '';
    } else {
      phone_number_error.innerHTML = '';
    }
  }
}
