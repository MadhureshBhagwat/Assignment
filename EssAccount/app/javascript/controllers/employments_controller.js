import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.submitForm();
    const inputFields = document.querySelectorAll('input[data-controller^="employments"]');
    inputFields.forEach(inputField => {
      inputField.addEventListener('input', () => {
        this.submitForm();
      });
    });
  }

  submitForm() {
    const employerName = document.getElementById('employerName').value;
    const startDate = document.getElementById('employment_date_started').value;
    const endDate = document.getElementById('employment_date_ended').value;

    const saveButton = document.getElementById('saveButton');

    if (employerName === '' || startDate === '' || endDate === '') {
      saveButton.classList.remove('bg-blue-600');
      saveButton.classList.add('bg-gray-400');
      saveButton.disabled = true;
    } else {
      saveButton.classList.remove('bg-gray-400');
      saveButton.classList.add('bg-blue-600');
      saveButton.disabled = false;
    }
  }
}
