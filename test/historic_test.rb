require 'test_helper'

class HistoricTest < Test::Unit::TestCase
  context "A HistoryItem, @item" do
    setup do
      HistoricItemHistory.delete_all
      HistoricItem.delete_all
      
      @item = HistoricItem.new
      @item.field_1, @item.field_2, @item.field_3 = 1, 2, 3
      @item.save!
    end

    should "not create a HistoryRecord when newly created" do
      assert !HistoricItemHistory.exists?(:field_1=>"1", :field_2=>"2", :field_3=>"3")
    end

    context "and a new value for :field_1" do
      setup do
        @new_field_1 = "4"
      end

      context "when changing the value of :field_1 to @new_field_1" do
        setup do
          @old_item = @item.clone
          @item.update_attributes(:field_1 => @new_field_1)
        end

        should "create a new ItemGuideHistory for the old item guide and item" do
          assert HistoricItemHistory.exists?({:field_1=>@old_item.field_1, :field_2=>@old_item.field_2, :field_3=>@old_item.field_3})
        end

        context ", the HistoricItemHistory" do
          setup do
            @item_history = HistoricItemHistory.find_by_field_1_and_field_2_and_field_3(@old_item.field_1, @old_item.field_2, @old_item.field_3)
          end

          should "copy a from the HistoricItem" do
            assert_equal @old_item.field_1, @item_history.field_1.to_i
          end

          should "copy b from the HistoricItem" do
            assert_equal @old_item.field_2, @item_history.field_2.to_i
          end

          should "copy c from the HistoricItem" do
            assert_equal @old_item.field_3, @item_history.field_3.to_i
          end

          should "clear c on the original HistoryItem" do
            assert_equal nil, @item.field_3
          end
        end #for the HistoricItemHistory
      end #when changing field_1 of HistoricIte
    end #when changing the value of :field_1 to @new_field_1

    context "passed to create_from_history_item" do
      setup do
        @item_history = HistoricItemHistory.create_history_from_current(@item)
      end

      should "copy a from the HistoricItem" do
        assert_equal @item.field_1, @item_history.field_1
      end

      should "copy b from the HistoricItem" do
        assert_equal @item.field_2, @item_history.field_2
      end

      should "copy c from the HistoricItem" do
        assert_equal @item.field_3, @item_history.field_3
      end

    end #passed to create_history_from_current

    context "when destroyed" do
      setup do
        assert_equal 0, HistoricItemHistory.count
        @item.destroy
      end

      should "create an HistoricItemHistory row" do
        assert_equal 1, HistoricItemHistory.count
        # assert HistoricItemHistory.exists?({:field_1=>@item.field_1, :field_2=>@item.field_2, :field_3=>@item.field_3})
      end
    end #when destroyed
  end # An item guide
end
