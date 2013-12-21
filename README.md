# autotable

`autotable` provides a single helper that converts a collection of model instances into a Bootstrap-compliant HTML table. Columns, data formatting and per-row action links are all fully customisable.

## Installation

Add this repository to your `Gemfile`. There is currently no official RubyGems release.

## Example

    <%=
    autotable(@collection, bordered: true) do |t|
      t.column :name
      t.column(:email) { |v,s| mail_to(v) }
      t.column :telephone
      t.column :country
      t.action 'View', url: :supplier_url,
                       class: 'btn-primary'
      t.action 'Edit', url: :edit_supplier_url,
                       class: 'btn-primary'
      t.action 'Delete', url: :supplier_url,
                         method: 'delete',
                         confirm: 'Are you sure?',
                         class: 'btn-danger'
    end
    %>

yields

![Autotable screenshot](https://raw.github.com/jaz303/autotable/master/screenshot.png)

## API

### Helper Methods

#### `autotable(collection, options = {}, &block)`

Generate an HTML table for collection `collection`.

Valid `options`:

  - `:action_class`: bass class name applied to action links. Default: `btn btn-sm`.
  - `:striped`: enable row-striping
  - `:bordered`: enable table border
  - `:hover`: enable row hover highlighting
  - `:condensed`: use condensed table layout

Table column and action configuration is achieved by passing a block to `autotable` which, when called, receives an instance of `Autotable::Builder` as an argument. This is documented below.

### Builder Methods

#### `column(method, title = nil, &formatter)`

Adds a column whose values are determined by sending `method` to each model instance. By default, the column's title is `method.to_s.humanize` but this can be overridden by passing `title` explicitly. The optional `formatter` block is used to format the column values and receives both the value and the model instance as parameters, and should return a sanitized HTML string.

#### `action(title, options = {})`

Adds an action to the table's rightmost "action" column.

Supported options:

  - `:icon`: icon to display in button; should correspond to one of Bootstrap's Glyphicons.
  - `:url`: URL for the action, one of:
    - `String`: explicit URL
    - `Proc`: should generate action URL when called; receives model instance as argument
    - `Hash`: arguments for a call to `url_for`; will be merged with `{id: object_instance}`
    - `Symbol`: name of URL helper method; receives model instance as argument
  - `:class`: class name; appended to builder's `:action_class`
  - `:confirm`, `:method`, `:remote`: forwarded to `link_to`

#### `to_html`

Generate table HTML and return it. You normally wouldn't call this method yourself - the `autotable` helper does it for you.