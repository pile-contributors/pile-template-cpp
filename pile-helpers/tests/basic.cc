#include <gtest/gtest.h>
#include <tempile/tempile.h>

class TestUsage : public ::testing::Test {

public:

    // this class wrapps TemPile, similar to normal usage
    class TestTemPile : public TemPile {
    public:
        TestTemPile() :
            TemPile(),
            delete_marker_(NULL) {}

        void setDelMarker(bool * value) {
            delete_marker_ = value;
            if (delete_marker_ != NULL) {
                *delete_marker_ = false;
            }
        }
    protected:
        ~TestTemPile() {
            if (delete_marker_ != NULL) {
                *delete_marker_ = true;
            }
        }
    private:
        // if provided, is set to true when this instance is deleted
        bool * delete_marker_;
    };

public:
    TestUsage () {}
    virtual ~TestUsage () {}

    void SetUp(){
        t_1 = new TestTemPile ();
        t_2 = new TestTemPile ();
        t_2->reference(this);
        t_3 = new TestTemPile ();
        t_3->reference(this);
        t_3->reference(this);
        t_4 = new TestTemPile ();
        t_4->reference(this);
        t_4->reference(this);
        t_4->reference(this);
    }
    void TearDown(){
        t_1->forceRelease();
        t_2->forceRelease();
        t_3->forceRelease();
        t_4->forceRelease();
    }

public:

    TestTemPile * t_1;
    TestTemPile * t_2;
    TestTemPile * t_3;
    TestTemPile * t_4;

};

TEST_F(TestUsage, initial_state) {
    EXPECT_EQ(t_1->referenceCount (), 1);
    EXPECT_EQ(t_2->referenceCount (), 2);
    EXPECT_EQ(t_3->referenceCount (), 3);
    EXPECT_EQ(t_4->referenceCount (), 4);
}

TEST_F(TestUsage, increasing) {
    t_1->reference(this);
    t_2->reference(this);
    t_3->reference(this);
    t_4->reference(this);
    EXPECT_EQ(t_1->referenceCount (), 2);
    EXPECT_EQ(t_2->referenceCount (), 3);
    EXPECT_EQ(t_3->referenceCount (), 4);
    EXPECT_EQ(t_4->referenceCount (), 5);
}

TEST_F(TestUsage, decreasing) {
    t_2->release(this);
    t_3->release(this);
    t_4->release(this);
    EXPECT_EQ(t_2->referenceCount (), 1);
    EXPECT_EQ(t_3->referenceCount (), 2);
    EXPECT_EQ(t_4->referenceCount (), 3);
}

TEST_F(TestUsage, delete_at_zero) {
    bool t_loc_1_deleted;
    TestUsage::TestTemPile * t_loc_1 =
            new TestUsage::TestTemPile();
    t_loc_1->setDelMarker (&t_loc_1_deleted);
    ASSERT_FALSE (t_loc_1_deleted);
    t_loc_1->release (this);
    ASSERT_TRUE (t_loc_1_deleted);
}
