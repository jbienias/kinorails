require 'test_helper'

class ReservedSeatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reserved_seat = reserved_seats(:one)
  end

  test "should get index" do
    get reserved_seats_url
    assert_response :success
  end

  test "should get new" do
    get new_reserved_seat_url
    assert_response :success
  end

  test "should create reserved_seat" do
    assert_difference('ReservedSeat.count') do
      post reserved_seats_url, params: { reserved_seat: { reservation_id: @reserved_seat.reservation_id, seat_id: @reserved_seat.seat_id } }
    end

    assert_redirected_to reserved_seat_url(ReservedSeat.last)
  end

  test "should show reserved_seat" do
    get reserved_seat_url(@reserved_seat)
    assert_response :success
  end

  test "should get edit" do
    get edit_reserved_seat_url(@reserved_seat)
    assert_response :success
  end

  test "should update reserved_seat" do
    patch reserved_seat_url(@reserved_seat), params: { reserved_seat: { reservation_id: @reserved_seat.reservation_id, seat_id: @reserved_seat.seat_id } }
    assert_redirected_to reserved_seat_url(@reserved_seat)
  end

  test "should destroy reserved_seat" do
    assert_difference('ReservedSeat.count', -1) do
      delete reserved_seat_url(@reserved_seat)
    end

    assert_redirected_to reserved_seats_url
  end
end
