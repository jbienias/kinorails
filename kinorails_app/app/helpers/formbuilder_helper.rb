module FormbuilderHelper

  def table_form_field(*attrs, &block)
      @template.send(:table_form_field, *attrs, &block)
  end

end
