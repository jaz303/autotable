# autotable

## Installation

Add this repository to your `Gemfile`. There is currently no official RubyGems release.

## Example

    <%=
    autotable(@collection, bordered: true) do |t|
      t.column :name
      t.column(:email) { |v,s| mail_to(v) }
      t.column :telephone
      t.column :country
      t.action 'View', url: :supplier_url, class: 'btn-primary'
      t.action 'Edit', url: :edit_supplier_url, class: 'btn-primary'
      t.action 'Delete', url: :supplier_url, method: 'delete', confirm: 'Are you sure?', class: 'btn-danger'
    end
    %>

## API


