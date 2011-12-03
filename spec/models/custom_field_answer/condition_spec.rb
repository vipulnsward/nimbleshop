require 'spec_helper'

describe CustomFieldAnswer::Condition do
  let(:query_sql)  { condition.to_condition.to_sql }

  describe "text condition" do

    it "should raise operator not supported exception" do
      proc {
        CustomFieldAnswer::Condition::TextCondition.new(op: 'lteq', v: 'george')
      }.must_raise CustomFieldAnswer::Condition::OperatorNotSupported
    end

    describe "#to_condition" do
      describe "#eq" do
        let(:condition) { CustomFieldAnswer::Condition::TextCondition.new(op: 'eq', v: 'george') }

        it "should create query for string equal" do
          query_sql.must_be_like %{
            "custom_field_answers"."value" ILIKE 'george'
          }
        end
      end

      describe "#starts" do
        let(:condition) { CustomFieldAnswer::Condition::TextCondition.new(op: 'starts', v: 'george') }

        it "should create query for string starts with" do
          query_sql.must_be_like %{
            "custom_field_answers"."value" ILIKE 'george%'
          }
        end
      end

      describe "#ends" do
        let(:condition) { CustomFieldAnswer::Condition::TextCondition.new(op: 'ends', v: 'george') }

        it "should create query for string starts with" do
          query_sql.must_be_like %{
            "custom_field_answers"."value" ILIKE '%george'
          }
        end
      end

      describe "#contains" do
        let(:condition) { CustomFieldAnswer::Condition::TextCondition.new(op: 'contains', v: 'george') }

        it "should create query for string starts with" do
          query_sql.must_be_like %{
            "custom_field_answers"."value" ILIKE '%george%'
          }
        end
      end
    end
  end

  describe "number condition" do

    it "should raise operator not supported exception" do
      proc {
        CustomFieldAnswer::Condition::NumberCondition.new(op: 'contains', v: 'george')
      }.must_raise CustomFieldAnswer::Condition::OperatorNotSupported
    end

    describe "#to_condition" do
      describe "#eq" do
        let(:condition) { CustomFieldAnswer::Condition::NumberCondition.new(op: 'eq', v: 24) }

        it "should create query for number equal" do
          query_sql.must_be_like %{
            "custom_field_answers"."number_value" = 24
          }
        end
      end

      describe "#lt" do
        let(:condition) { CustomFieldAnswer::Condition::NumberCondition.new(op: 'lt', v: 24) }

        it "should create query for number less than" do
          query_sql.must_be_like %{
            "custom_field_answers"."number_value" < 24
          }
        end
      end

      describe "#gt" do
        let(:condition) { CustomFieldAnswer::Condition::NumberCondition.new(op: 'gt', v: 24) }

        it "should create query for number greater than" do
          query_sql.must_be_like %{
            "custom_field_answers"."number_value" > 24
          }
        end
      end

      describe "#lteq" do
        let(:condition) { CustomFieldAnswer::Condition::NumberCondition.new(op: 'lteq', v: 24) }

        it "should create query for number less than equal" do
          query_sql.must_be_like %{
            "custom_field_answers"."number_value" <= 24
          }
        end
      end

      describe "#gteq" do
        let(:condition) { CustomFieldAnswer::Condition::NumberCondition.new(op: 'gteq', v: 24) }

        it "should create query for number greater than equal" do
          query_sql.must_be_like %{
            "custom_field_answers"."number_value" >= 24
          }
        end
      end
    end
  end

  describe "date condition" do
    describe "#to_condition" do
      describe "#eq" do
        let(:condition) { CustomFieldAnswer::Condition::DateCondition.new(op: 'eq', v: '1/2/2009') }

        it "should create query for date equal" do
          query_sql.must_be_like %{
            "custom_field_answers"."datetime_value" = '1/2/2009'
          }
        end
      end

      describe "#lt" do
        let(:condition) { CustomFieldAnswer::Condition::DateCondition.new(op: 'lt', v: '1/2/2009') }

        it "should create query for date less than" do
          query_sql.must_be_like %{
            "custom_field_answers"."datetime_value" < '1/2/2009'
          }
        end
      end

      describe "#gt" do
        let(:condition) { CustomFieldAnswer::Condition::DateCondition.new(op: 'gt', v: '1/2/2009') }

        it "should create query for date greater than" do
          query_sql.must_be_like %{
            "custom_field_answers"."datetime_value" > '1/2/2009'
          }
        end
      end

      describe "#lteq" do
        let(:condition) { CustomFieldAnswer::Condition::DateCondition.new(op: 'lteq', v: '1/2/2009') }

        it "should create query for date less than equal" do
          query_sql.must_be_like %{
            "custom_field_answers"."datetime_value" <= '1/2/2009'
          }
        end
      end

      describe "#gteq" do
        let(:condition) { CustomFieldAnswer::Condition::DateCondition.new(op: 'gteq', v: '1/2/2009') }

        it "should create query for date greater than equal" do
          query_sql.must_be_like %{
            "custom_field_answers"."datetime_value" >= '1/2/2009'
          }
        end
      end
    end
  end
end