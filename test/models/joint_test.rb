require "test_helper"

class JointTest < ActiveSupport::TestCase
  test "builds a name when blank on create" do
    joint = Joint.new
    assert_nil joint.name

    joint.save

    assert_not_nil joint.name
    assert_match(/^(My|Shy|Fly) (Guys|Girls) \d{1,3}$/, joint.name)
  end

  test "does not override existing name on create" do
    custom_name = "Custom Joint Name"
    joint = Joint.new(name: custom_name)

    joint.save

    assert_equal custom_name, joint.name
  end

  test "generates unique names" do
    joints = 5.times.map { Joint.create }
    names = joints.map(&:name)

    assert_equal names.uniq.length, names.length, "Generated names should be unique"
  end

  test "name format includes first name, last name, and number" do
    joint = Joint.create

    parts = joint.name.split(" ")
    assert_equal 3, parts.length

    assert_includes %w[My Shy Fly], parts[0]
    assert_includes %w[Guys Girls], parts[1]
    assert_match(/^\d{1,3}$/, parts[2])
    assert parts[2].to_i.between?(0, 100)
  end

  test "slug is generated from auto-generated name" do
    joint = Joint.create

    assert_not_nil joint.slug
    assert_not joint.slug.match?(/^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$/), "Slug should not be a UUID"

    expected_slug_pattern = /^(my|shy|fly)-(guys|girls)-\d{1,3}$/
    assert_match expected_slug_pattern, joint.slug
  end

  test "slug matches parameterized name" do
    joint = Joint.create

    expected_slug = joint.name.parameterize
    assert_equal expected_slug, joint.slug
  end
end
