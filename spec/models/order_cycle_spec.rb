require 'spec_helper'

describe OrderCycle do
  it "should be valid when built from factory" do
    build(:simple_order_cycle).should be_valid
  end

  it "should not be valid without a name" do
    oc = build(:simple_order_cycle)
    oc.name = ''
    oc.should_not be_valid
  end

  it "has a coordinator and associated fees" do
    oc = create(:simple_order_cycle)

    oc.coordinator = create(:enterprise)
    oc.coordinator_admin_fee = create(:enterprise_fee)
    oc.coordinator_sales_fee = create(:enterprise_fee)

    oc.save!
  end

  it "has exchanges" do
    oc = create(:simple_order_cycle)

    create(:exchange, order_cycle: oc)
    create(:exchange, order_cycle: oc)
    create(:exchange, order_cycle: oc)

    oc.exchanges.count.should == 3
  end

  it "reports its suppliers" do
    oc = create(:simple_order_cycle)

    e1 = create(:exchange,
                order_cycle: oc, receiver: oc.coordinator, sender: create(:enterprise))
    e2 = create(:exchange,
                order_cycle: oc, receiver: oc.coordinator, sender: create(:enterprise))

    oc.suppliers.sort.should == [e1.sender, e2.sender].sort
  end

  it "reports its distributors" do
    oc = create(:simple_order_cycle)

    e1 = create(:exchange,
                order_cycle: oc, sender: oc.coordinator, receiver: create(:enterprise))
    e2 = create(:exchange,
                order_cycle: oc, sender: oc.coordinator, receiver: create(:enterprise))

    oc.distributors.sort.should == [e1.receiver, e2.receiver].sort
  end

  describe "product exchanges" do
    before(:each) do
      @oc = create(:simple_order_cycle)

      e1 = create(:exchange,
                  order_cycle: @oc, sender: @oc.coordinator, receiver: create(:enterprise))
      e2 = create(:exchange,
                  order_cycle: @oc, sender: @oc.coordinator, receiver: create(:enterprise))

      @p1 = create(:product)
      @p2 = create(:product)
      @p2_v = create(:variant, product: @p2)

      e1.variants << @p1.master
      e1.variants << @p2.master
      e1.variants << @p2_v
      e2.variants << @p1.master
    end

    it "reports on the variants exchanged in the order cycle" do
      @oc.variants.sort.should == [@p1.master, @p2.master, @p2_v].sort
    end

    it "reports on the products exchanged in the order cycle" do
      @oc.products.sort.should == [@p1, @p2]
    end
  end
end
