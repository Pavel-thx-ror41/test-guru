const CONFIRMATION_CLASS_MARKER_SUFFIX = '_confirmation'

document.addEventListener('turbolinks:load', function() {
    let confirmations_inputs = document.querySelectorAll(`input[id$='${CONFIRMATION_CLASS_MARKER_SUFFIX}']`)

    if (confirmations_inputs.length > 0) {
        confirmations_inputs.forEach(
            function (currentConfirmationInput, currentIndex) {
                // add handlers for *_confirmation inputs
                currentConfirmationInput.addEventListener('input', handleInputChange);

                // add handlers for (paired) * inputs
                let currentInput = getPairedInput(currentConfirmationInput.id)
                if (currentInput.id.valueOf() === getPairedInput(currentConfirmationInput.id).id.valueOf()) {
                    currentInput.addEventListener('input', handleInputChange);
                }
            }
        )
    }
})

function handleInputChange() {
    const BOOTSTRAP_INPUT_ERROR_CLASS_NAME = 'is-invalid'

    if (this.value.valueOf() === getPairedInput(this.id).value) {
        this.classList.remove(BOOTSTRAP_INPUT_ERROR_CLASS_NAME)
        getPairedInput(this.id).classList.remove(BOOTSTRAP_INPUT_ERROR_CLASS_NAME)
    } else {
        this.classList.add(BOOTSTRAP_INPUT_ERROR_CLASS_NAME)
        getPairedInput(this.id).classList.add(BOOTSTRAP_INPUT_ERROR_CLASS_NAME)
    }
}

function getPairedInput(id) {
    let inputPairName = getPairedInputName(id)
    let inputPair = document.querySelector(`input[id$=${inputPairName}]`)

    if (inputPair.id.valueOf() === inputPairName.valueOf()) { return inputPair }
}

function getPairedInputName(id) {
    if (id.endsWith(CONFIRMATION_CLASS_MARKER_SUFFIX)) {
        return id.replace(CONFIRMATION_CLASS_MARKER_SUFFIX, '')
    } else {
        return `${id}${CONFIRMATION_CLASS_MARKER_SUFFIX}`
    }
}
