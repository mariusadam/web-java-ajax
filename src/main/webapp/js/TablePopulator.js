/**
 * Created by mariusadam on 6/3/17.
 */
/**
 *
 * @param tableId
 * @param entities
 * @param columns The order of the properties in a row
 */
function TablePopulator(tableId, columns) {
    this.tableId = tableId;
    this.columns = columns;
    this.deleteHandler = function () {
    };
}

TablePopulator.prototype.setDeleteHandler = function (deleteHandler) {
    this.deleteHandler = deleteHandler;
};

TablePopulator.prototype.clearTable = function () {
    $('#' + this.tableId).find('tbody').empty();
};

TablePopulator.prototype.rowId = function (entityId) {
    return this.tableId + '-row-' + entityId;
};

TablePopulator.prototype.deleteButtonId = function (entityId) {
    return this.tableId + '-delete-button-' + entityId;
};

TablePopulator.prototype.addEntities = function (entities) {
    var $tableBody = $('#' + this.tableId).find('tbody');

    for (var i = 0; i < entities.length; i++) {
        var entity = entities[i];
        var buttonId = this.deleteButtonId(entity.id);
        var rowId = this.rowId(entity.id);
        var $tr = $('<tr>').attr('id', rowId);

        for (var j = 0; j < this.columns.length; j++) {
            var property = this.columns[j];
            $tr.append($('<td>').append(entity[property]));
        }

        var $deleteBtn = $('<button id="' + buttonId + '" type="button" class="btn btn-danger delete-team">Delete &times;</button>');
        $tr.append($('<td>').append($deleteBtn));
        $tableBody.append($tr);

        var $thisPopulator = this;
        $deleteBtn.click(function (e) {
            var entityId = this.id.split('-').last();

            $thisPopulator.deleteHandler(entityId);
        });
    }
};