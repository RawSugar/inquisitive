module ArrayTests
  def test_array_value_type
    assert_instance_of Inquisitive::Array, array
  end
  def test_array_match
    assert array.postgres?
  end
  def test_array_miss
    refute array.sql_server?
  end
  def test_array_negative_match
    assert array.exclude.sql_server?
  end
  def test_array_negative_miss
    refute array.exclude.postgres?
  end
  def test_array_double_negative_match
    assert array.exclude.exclude.postgres?
  end
  def test_array_double_negative_miss
    refute array.exclude.exclude.sql_server?
  end
  def test_array_missing_question_mark
    assert_raises(NoMethodError) { array.postgres }
  end
  def test_array_respond_to
    assert_respond_to array, :postgres?
  end
end