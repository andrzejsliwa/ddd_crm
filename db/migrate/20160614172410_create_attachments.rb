class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.references :attachable, polymorphic: true, index: true
      t.references :user
      t.attachment :document

      t.timestamps
    end
  end
end