require_relative 'test_helper'
require './lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def setup
    item_file_path = './test/fixtures/items_truncated.csv'
    merchant_file_path = './test/fixtures/merchants_truncated.csv'
    invoice_file_path = './test/fixtures/invoices_truncated.csv'
    @engine = SalesEngine.new(item_file_path, merchant_file_path, invoice_file_path)
    @analyst = SalesAnalyst.new(@engine)
  end

  def test_it_exists
    assert_instance_of SalesAnalyst, @analyst
    assert_instance_of SalesEngine, @engine
  end

  def test_item_count_returns_total_number_of_items
    repo = @engine.merchants

    assert_equal 3, @analyst.total_item_count_per_merchant(repo)
  end

  def test_average_items_per_merchant_returns_decimal_mean
    assert_equal 0.75, @analyst.average_items_per_merchant
  end

  def test_it_can_find_sum_of_square_differences_for_item_count
    merchant_repo = @engine.merchants

    assert_equal 6.75, @analyst.sum_of_square_differences_item_count(merchant_repo, 0.75)
  end

  def test_it_can_find_sample_variance
    merchant_repo = @engine.merchants

    assert_equal 2.25, @analyst.find_sample_variance(merchant_repo, 6.75)
  end

  def test_average_items_per_merchant_standard_deviation_returns_deviation_from_mean
    assert_equal 1.5, @analyst.average_items_per_merchant_standard_deviation
  end

  def test_merchants_with_high_item_count_returns_merchants_more_than_one_standard_deviation_above
    high_sellers = @analyst.merchants_with_high_item_count

    assert_equal 12334185, high_sellers[0].id
    assert_equal 1, high_sellers.count
  end

  def test_average_item_price_for_merchant_returns_average_of_merchants_items
    assert_equal 0.1117e2, @analyst.average_item_price_for_merchant(12334185)

  end

  def test_average_average_price_per_merchant_returns_average_of_all
    assert_equal 0.279e1, @analyst.average_average_price_per_merchant
  end

  def test_it_can_find_sum_of_square_differences_for_item_price
    merchant_repo = @engine.merchants

    assert_equal 93.5767, @analyst.sum_of_square_differences_item_price(merchant_repo, 2.79)
  end

  def test_average_item_price_standard_deviation_returns_deviation_from_mean
    assert_equal 5.59, @analyst.average_item_price_standard_deviation
  end

  def test_golden_items_returns_array_of_items_two_standard_deviations_above_in_price
    golden_items = @analyst.golden_items

    assert_equal 2, golden_items.count
  end

  def test_it_can_find_average_invoices_per_merchant
    assert_equal 3.5, @analyst.average_invoices_per_merchant
  end

  def test_it_can_find_sum_of_square_differences_for_invoice_count
    merchant_repo = @engine.merchants

    assert_equal 57, @analyst.sum_of_square_differences_invoice_count(merchant_repo, 3.5)
  end

  def test_it_can_find_standard_deviation_for_merchant_invoices
    assert_equal 4.36, @analyst.average_invoice_count_standard_deviation
  end

  def test_it_can_find_top_merchants_by_invoice_count
    top_merchants = @analyst.top_merchants_by_invoice_count
    merchant = top_merchants[0]

    assert_equal 12334185, merchant.id
    assert_equal 1, top_merchants.length

  end

  def test_it_can_find_bottom_merchants_by_invoice_count
    bottom_merchants = @analyst.bottom_merchants_by_invoice_count

    assert_equal 3, bottom_merchants.length
    assert_instance_of Merchant, bottom_merchants[0]

  end

  def test_it_can_find_average_invoices_per_day
    assert_equal 2, @analyst.average_invoices_per_day
  end

  def test_it_can_find_days_of_week_invoices_were_created
    assert_equal [5, 3, 5, 4, 5, 6, 3, 4, 4, 3, 1, 3, 6, 2], @analyst.invoice_creation_days
  end

  def test_it_can_find_how_many_invoices_were_created_per_day
    assert_equal [0, 1, 1, 4, 3, 3, 2], @analyst.invoices_created_per_day
  end

  def test_it_can_find_sum_of_square_differences_for_invoices_per_day
    invoices_per_day = [0, 1, 1, 4, 3, 3, 2]
    assert_equal 12, @analyst.sum_of_square_differences_invoices_per_day(invoices_per_day, 2)
  end

  def test_it_can_find_day_of_week_standard_deviation
    assert_equal 0.96, @analyst.invoices_per_day_standard_deviation
  end

  def test_it_finds_top_days_by_invoice_count
    assert_equal ["Wednesday", "Thursday", "Friday", "Saturday"], @analyst.top_days_by_invoice_count
  end

  def test_it_can_find_percentage_of_invoices_shipped

end