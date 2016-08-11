class V1::MacroTaskSerializer < ActiveModel::Serializer
  attributes :id, :title, :notes

  belongs_to :project do
    {
      id: object.project.id,
      title: object.project.title
    }
  end

  belongs_to :worker, key: :created_by do
    {
      id: object.worker.id,
      name: object.worker.name
    }
  end
end
