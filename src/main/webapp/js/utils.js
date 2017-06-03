function populateForm(formId, entity) {
    for (var property in entity) {
        if (!entity.hasOwnProperty(property)) {
            continue;
        }
        // console.log(property);
        $('#' + formId + '_' + property).val(entity[property]);
    }
}

function writeMessage(targetId, type, msg) {
    var $alertDiv = $('<div>')
        .addClass('alert')
        .addClass('alert-' + type)
        .addClass('alert-dismissable')
        .addClass('fade')
        .addClass('in')
        .append(
            $('<a>')
                .attr('href', '#')
                .attr('data-dismiss', 'alert')
                .attr('aria-label', 'close')
                .addClass('close')
                .append('&times;')
        )
        .append(msg);

    $('#' + targetId).append($alertDiv);

    $alertDiv.fadeTo(2000, 500).slideUp(500, function () {
        $alertDiv.slideUp(500);
    });
}

if (!Array.prototype.last) {
    Array.prototype.last = function () {
        return this[this.length - 1];
    };
}

function hardResetForm(formName) {
    $(':input', 'form[name="' + formName + '"]')
        .not(':button, :submit, :reset, :hidden')
        .val('')
        .removeAttr('checked')
        .removeAttr('selected');
}