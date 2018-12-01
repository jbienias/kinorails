require "application_system_test_case"

class ReservedSeatsTest < ApplicationSystemTestCase
  setup do
    @reserved_seat = reserved_seats(:one)
  end

  test "visiting the index" do
    visit reserved_seats_url
    assert_selector "h1", text: "Reserved Seats"
  end

  test "creating a Reserved seat" do
    visit reserved_seats_url
    click_on "New Reserved Seat"

    fill_in "Reservation", with: @reserved_seat.reservation_id
    fill_in "Seat", with: @reserved_seat.seat_id
    click_on "Create Reserved seat"

    assert_text "Reserved seat was successfully created"
    click_on "Back"
  end

  test "updating a Reserved seat" do
    visit reserved_seats_url
    click_on "Edit", match: :first

    fill_in "Reservation", with: @reserved_seat.reservation_id
    fill_in "Seat", with: @reserved_seat.seat_id
    click_on "Update Reserved seat"

    assert_text "Reserved seat was successfully updated"
    click_on "Back"
  end

  test "destroying a Reserved seat" do
    visit reserved_seats_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reserved seat was successfully destroyed"
  end
end
