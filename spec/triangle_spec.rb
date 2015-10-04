require File.expand_path(File.dirname(__FILE__) + '/../triangle')

describe Triangle do

  describe "入力値不正テスト" do
    
    #三角形のオブジェクトを作成
    triangle1 = Triangle.new()
    
    specify "数値以外を渡す" do
      triangle1.setTriangleSide("1", 2, 3)
      expect(triangle1.chkFormingCondition()).to eq false
      expect(triangle1.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
      expect(triangle1.msg).to eq Triangle::MSG_NOT_NUM_SIDE_1
      
      triangle1.setTriangleSide(1, "2", 3)
      expect(triangle1.chkFormingCondition()).to eq false
      expect(triangle1.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
      expect(triangle1.msg).to eq Triangle::MSG_NOT_NUM_SIDE_2
      
      triangle1.setTriangleSide(1, 2, "3")
      expect(triangle1.chkFormingCondition()).to eq false
      expect(triangle1.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
      expect(triangle1.msg).to eq Triangle::MSG_NOT_NUM_SIDE_3
    end
    
    specify "0値を渡す" do
      triangle1.setTriangleSide(0, 2, 3)
      expect(triangle1.chkFormingCondition()).to eq false
      expect(triangle1.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
      expect(triangle1.msg).to eq Triangle::MSG_NOT_TRIANGLE

      triangle1.setTriangleSide(1, 0, 3)
      expect(triangle1.chkFormingCondition()).to eq false
      expect(triangle1.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
      expect(triangle1.msg).to eq Triangle::MSG_NOT_TRIANGLE

      triangle1.setTriangleSide(1, 2, 0)
      expect(triangle1.chkFormingCondition()).to eq false
      expect(triangle1.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
      expect(triangle1.msg).to eq Triangle::MSG_NOT_TRIANGLE
    end
    
    specify "マイナス値を渡す" do
      triangle1.setTriangleSide(-1, 2, 3)
      expect(triangle1.chkFormingCondition()).to eq false
      expect(triangle1.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
      expect(triangle1.msg).to eq Triangle::MSG_NOT_TRIANGLE

      triangle1.setTriangleSide(1, -1, 3)
      expect(triangle1.chkFormingCondition()).to eq false
      expect(triangle1.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
      expect(triangle1.msg).to eq Triangle::MSG_NOT_TRIANGLE

      triangle1.setTriangleSide(1, 2, -1)
      expect(triangle1.chkFormingCondition()).to eq false
      expect(triangle1.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
      expect(triangle1.msg).to eq Triangle::MSG_NOT_TRIANGLE
    end
  end

  describe "同値分析" do
  
    #三角形のオブジェクトを作成
    triangle2 = Triangle.new()
    
    #100回ループ
    100.times do |i|
    
      specify "三角形確認" do
      
        a = rand(100) + 1
        b = rand(100) + 1
        #(a + b - 1) - (a - b).absはランダムの範囲、それに最小値の (a - b)の絶対値 + 1を足して必ず a + b > c, a + c > b, b + c > a が成立するようにする。
        c = rand((a + b - 1) - (a - b).abs) + (a - b).abs + 1
        
        printf a.to_s + "," +  b.to_s + "," + c.to_s + "="
        
        triangle2.setTriangleSide(a, b, c)
        expect(triangle2.chkFormingCondition()).to eq true
        expect(triangle2.msg).to eq Triangle::MSG_TRIANGLE
        expect(triangle2.getTriangleType()).not_to eq Triangle::TYPE_NOT_TRIANGEL
        expect(triangle2.msg).not_to eq Triangle::MSG_NOT_TRIANGLE
        
        triangle2.setTriangleSide(b, c, a)
        expect(triangle2.chkFormingCondition()).to eq true
        expect(triangle2.msg).to eq Triangle::MSG_TRIANGLE
        expect(triangle2.getTriangleType()).not_to eq Triangle::TYPE_NOT_TRIANGEL
        expect(triangle2.msg).not_to eq Triangle::MSG_NOT_TRIANGLE

        triangle2.setTriangleSide(c, a, b)
        expect(triangle2.chkFormingCondition()).to eq true
        expect(triangle2.msg).to eq Triangle::MSG_TRIANGLE
        expect(triangle2.getTriangleType()).not_to eq Triangle::TYPE_NOT_TRIANGEL
        expect(triangle2.msg).not_to eq Triangle::MSG_NOT_TRIANGLE

      end
      
      specify "三角形でない" do
      
        a = rand(100) + 1
        b = rand(100) + 1
        c = rand(100) + a + b
        
        printf a.to_s + "," +  b.to_s + "," + c.to_s + "="
        
        triangle2.setTriangleSide(a, b, c)
        expect(triangle2.chkFormingCondition()).to eq false
        expect(triangle2.msg).to eq Triangle::MSG_NOT_TRIANGLE
        expect(triangle2.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
        expect(triangle2.msg).to eq Triangle::MSG_NOT_TRIANGLE
        
        triangle2.setTriangleSide(b, c, a)
        expect(triangle2.chkFormingCondition()).to eq false
        expect(triangle2.msg).to eq Triangle::MSG_NOT_TRIANGLE
        expect(triangle2.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
        expect(triangle2.msg).to eq Triangle::MSG_NOT_TRIANGLE

        triangle2.setTriangleSide(c, a, b)
        expect(triangle2.chkFormingCondition()).to eq false
        expect(triangle2.msg).to eq Triangle::MSG_NOT_TRIANGLE
        expect(triangle2.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
        expect(triangle2.msg).to eq Triangle::MSG_NOT_TRIANGLE

      end
      
      specify "正三角形" do
      
        a = rand(100) + 1
        
        printf a.to_s + "*3="
        
        triangle2.setTriangleSide(a, a, a)
        expect(triangle2.chkFormingCondition()).to eq true
        expect(triangle2.msg).to eq Triangle::MSG_TRIANGLE
        expect(triangle2.getTriangleType()).to eq Triangle::TYPE_EQUILATERAL
        expect(triangle2.msg).to eq Triangle::MSG_TRIANGLE_EQUILATERAL
        
      end
      
      specify "二等辺三角形" do
      
        a = rand(100) + 2
        b = a
        c = rand(2 * a - 1) + 1
        
        #正三角形にならないようにする
        if a == c
          c += 1
        end 
        
        printf a.to_s + "," +  b.to_s + "," + c.to_s + "="
        
        triangle2.setTriangleSide(a, b, c)
        expect(triangle2.chkFormingCondition()).to eq true
        expect(triangle2.msg).to eq Triangle::MSG_TRIANGLE
        expect(triangle2.getTriangleType()).to eq Triangle::TYPE_ISOSCELES
        expect(triangle2.msg).to eq Triangle::MSG_TRIANGLE_ISOSCELES
        
        triangle2.setTriangleSide(b, c, a)
        expect(triangle2.chkFormingCondition()).to eq true
        expect(triangle2.msg).to eq Triangle::MSG_TRIANGLE
        expect(triangle2.getTriangleType()).to eq Triangle::TYPE_ISOSCELES
        expect(triangle2.msg).to eq Triangle::MSG_TRIANGLE_ISOSCELES

        triangle2.setTriangleSide(c, a, b)
        expect(triangle2.chkFormingCondition()).to eq true
        expect(triangle2.msg).to eq Triangle::MSG_TRIANGLE
        expect(triangle2.getTriangleType()).to eq Triangle::TYPE_ISOSCELES
        expect(triangle2.msg).to eq Triangle::MSG_TRIANGLE_ISOSCELES

      end

    end
    
  end

  describe "境界値分析" do
  
    #三角形のオブジェクトを作成
    triangle3 = Triangle.new()
    
    #100回ループ
    100.times do |i|
    
      specify "三角形であることの境界値" do
        a = rand(100) + 1
        b = rand(100) + 1
        c = a + b - 1
        
        printf a.to_s + "," +  b.to_s + "," + c.to_s + "="
        
        triangle3.setTriangleSide(a, b, c)
        expect(triangle3.chkFormingCondition()).to eq true
        expect(triangle3.msg).to eq Triangle::MSG_TRIANGLE
        expect(triangle3.getTriangleType()).not_to eq Triangle::TYPE_NOT_TRIANGEL
        expect(triangle3.msg).not_to eq Triangle::MSG_NOT_TRIANGLE
        
        triangle3.setTriangleSide(b, c, a)
        expect(triangle3.chkFormingCondition()).to eq true
        expect(triangle3.msg).to eq Triangle::MSG_TRIANGLE
        expect(triangle3.getTriangleType()).not_to eq Triangle::TYPE_NOT_TRIANGEL
        expect(triangle3.msg).not_to eq Triangle::MSG_NOT_TRIANGLE

        triangle3.setTriangleSide(c, a, b)
        expect(triangle3.chkFormingCondition()).to eq true
        expect(triangle3.msg).to eq Triangle::MSG_TRIANGLE
        expect(triangle3.getTriangleType()).not_to eq Triangle::TYPE_NOT_TRIANGEL
        expect(triangle3.msg).not_to eq Triangle::MSG_NOT_TRIANGLE
    
      end
      
      specify "三角形ではないことの境界値" do
        a = rand(100) + 1
        b = rand(100) + 1
        c = a + b
        
        printf a.to_s + "," +  b.to_s + "," + c.to_s + "="
        
        triangle3.setTriangleSide(a, b, c)
        expect(triangle3.chkFormingCondition()).to eq false
        expect(triangle3.msg).not_to eq Triangle::MSG_TRIANGLE
        expect(triangle3.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
        expect(triangle3.msg).to eq Triangle::MSG_NOT_TRIANGLE
        
        triangle3.setTriangleSide(b, c, a)
        expect(triangle3.chkFormingCondition()).to eq false
        expect(triangle3.msg).not_to eq Triangle::MSG_TRIANGLE
        expect(triangle3.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
        expect(triangle3.msg).to eq Triangle::MSG_NOT_TRIANGLE

        triangle3.setTriangleSide(c, a, b)
        expect(triangle3.chkFormingCondition()).to eq false
        expect(triangle3.msg).not_to eq Triangle::MSG_TRIANGLE
        expect(triangle3.getTriangleType()).to eq Triangle::TYPE_NOT_TRIANGEL
        expect(triangle3.msg).to eq Triangle::MSG_NOT_TRIANGLE

      end
    end
  end

end

