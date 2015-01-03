class Importer
  attr_reader :error

  def initialize(user_id, bank_account_id, file, separator, encoding, skip_rows, cols)
    @error = ''

    @file = file
    @separator = separator
    @encoding = encoding
    @cols = cols
    @skip_rows = Integer(skip_rows)
    @user_id = user_id
    @bank_account_id = bank_account_id
  end

  def import
    File.open(@file, "r").each_line { |line|
      if @skip_rows > 0
        @skip_rows -= 1
      else
        data = line.encode('utf-8', @encoding, :invalid => :replace, :undef => :replace, :replace => '').split(@separator)
        attrs = combine data
        fix_attrs attrs
        if !Operation.exists?(attrs)
          Operation.new(attrs).save
        end
      end
    }
    return true
  end

  private

  def combine(data)
    ret = {}
    @cols.each_with_index { |item, i|
      if item == ''
        continue
      end
      ret[item[1]] = data[i].strip
    }
    ret['user_id'] = @user_id
    ret['bank_accounts_id'] = @bank_account_id
    return ret
  end

  def fix_attrs(data)
    if data['type'] != '' && data['type'] != nil
      ot = OperationType.find_by(:type => data['type'])
      if ot == nil
        ot = OperationType.new(type: data['type'])
        ot.save
      end
      data['type_id'] = ot.id
    end
    data.except!('type')

    if data['accounting_date'] != '' && data['accounting_date'] != nil
      data['accounting_date'] = data['accounting_date'][0..3]+"-"+data['accounting_date'][4..5]+"-"+data['accounting_date'][6..7]
    end
    if data['currency_date'] != '' && data['currency_date'] != nil
      data['currency_date'] = data['currency_date'][0..3]+"-"+data['currency_date'][4..5]+"-"+data['currency_date'][6..7]
    end
  end

end