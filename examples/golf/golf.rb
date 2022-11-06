# frozen_string_literal: true

require_relative '../../lib/tealrb'

class Golf < TEALrb::Contract
  @version = 8

  def main
    approve if this_txn.application_id == 0
    $uint16 = extract(6, 2, app_args[0])

    if box_exists?('ints')
      # https://stackoverflow.com/a/21822316
      # function sortedIndex(array, value) {
      #  var low = 0,
      #      high = array.length;
      #
      # while (low < high) {
      #   var mid = (low + high) >>> 1;
      # if (array[mid] < value) low = mid + 1;
      # else high = mid;
      # }
      # return low;
      # }
      $value = btoi app_args[0]
      $low = 0
      $high = box_len_value('ints') / 2

      while $low < $high
        $mid = ($low + $high) / 2
        $mid_value = btoi box_extract('ints', $mid * 2, 2)

        if $mid_value < $value
          $low = $mid + 1
        else
          $high = $mid
        end
      end

      $offset = $low * 2

      $before = box_extract('ints', 0, $offset)
      $after = box_extract('ints', $offset, box_len_value('ints') - $offset)

      $new_box_value = concat(concat($before, $uint16), $after)
      $last_len = box_len_value('ints')

      box_del 'ints'
      box_create 'ints', $last_len + 2
      box['ints'] = $new_box_value
    else
      box_create('ints', 2)
      box['ints'] = $uint16
    end

    log box['ints']
    log(itob(global.opcode_budget))
    approve
  end
end

Golf.new.dump(abi: false)
