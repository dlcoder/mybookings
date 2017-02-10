require 'rails_helper'

module Mybookings
  describe User do
    let(:user) { User.new }

    describe "get_all_posibles_masks_for_roles" do

      it 'should return an empty array if the user not have any role assigned' do
          expect(user.get_all_posibles_masks_for_roles).to eq([])
          expect(user.get_all_posibles_masks_for_roles).to_not eq([1])
      end

      it 'should return an array with all the posibles valid masks if the user has the admin role' do
        user.roles = [:admin]

        expect(user.get_all_posibles_masks_for_roles).to eq([1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31])
        expect(user.get_all_posibles_masks_for_roles).to_not eq([1, 5, 7, 9, 17, 19, 27, 29, 31])
      end

      it 'should return an array with all the posibles valid masks if the user has the manager role' do
        user.roles = [:manager]

        expect(user.get_all_posibles_masks_for_roles).to eq([2, 3, 6, 7, 10, 11, 14, 15, 18, 19, 22, 23, 26, 27, 30, 31])
        expect(user.get_all_posibles_masks_for_roles).to_not eq([2, 11, 14, 15, 23, 26, 27, 30, 31])
      end

      it 'should return an array with all the posibles valid masks if the user has the admin and manager roles assigned' do
        user.roles = [:admin, :manager]

        expect(user.get_all_posibles_masks_for_roles).to eq([1, 2, 3, 5, 6, 7, 9, 10, 11, 13, 14, 15 ,17, 18, 19, 21, 22, 23, 25, 26, 27, 29, 30, 31])
        expect(user.get_all_posibles_masks_for_roles).to_not eq([1, 10, 11, 13, 14, 25, 26, 27, 29, 30, 31])
      end
    end
  end
end
