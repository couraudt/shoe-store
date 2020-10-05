ActionCable.createConsumer().subscriptions.create("DashboardChannel", {
  count: 0,
  received(data) {
    $('#last_events table tbody').prepend($('<tr>')
      .addClass(this.count % 2 === 0 ? 'odd' : 'even')
      .append($('<td>')
        .append($('<a>').attr('href', '/stores/'+data.store.id).text(data.store.name))
      )
      .append($('<td>')
        .append($('<a>').attr('href', '/models/'+data.store_model.id).text(data.store_model.name))
      )
      .append($('<td>')
        .append(data.inventory)
      )
    ).find("tr:gt(19)").remove();
    this.count++;
  }
});
