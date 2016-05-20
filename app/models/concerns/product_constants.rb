module ProductConstants
  ADULT_TYPES = {
    'Shirt'      =>   0,
    'Tshirt'     =>   1,
    'Underwear'  =>   2,
    'Trouser'    =>   3,
    'Jacket'     =>   4,
    'Blazer'     =>   5,
    'Belt'       =>   6,
    'Hat'        =>   7,
    'Glove'      =>   8
  }.freeze

  CHILD_TYPES = {
    'Cloth'      =>   9,
    'Toy'        =>   10,
    'Education'  =>   11,
    'Food'       =>   12,
    'Nappy'      =>   13,
    'Hygiene'    =>   14,
    'Furtiture'  =>   15,
    'School'     =>   16,
    'Transport'  =>   17
  }.freeze

  COMMON_TYPES = {
    'Shoe'       =>   18,
    'Sock'       =>   19
  }.freeze

  TYPES = ADULT_TYPES.merge(CHILD_TYPES).merge(COMMON_TYPES)

  SIZES = {
    'Russian Sizes'      =>   0,
    'Euro Sizes'         =>   1,
    'British Sizes'      =>   2,
    'American Sizes'     =>   3,
    'Hight Sizes'        =>   4
  }.freeze

  # Child constants class
  AGE_SIZES = {
    '1-3 mo'     => 0,
    '4-6 mo'     => 1,
    '7-9 mo'     => 2,
    '10-12 mo'   => 3,
    '13-15 mo'   => 4,
    '16-18 mo'   => 5,
    '19-21 mo'   => 6,
    '22-24 mo'   => 7
  }.freeze

  AGE_SIZES_VALUES = {
    '0.25'   => 0,
    '0.5'    => 1,
    '0.75'   => 2,
    '1'      => 3,
    '1.25'   => 4,
    '1.5'    => 5,
    '1.75'   => 6,
    '2'      => 7
  }.freeze

  AGES = {
    'Age less then 2 years' => 0,
    'Age more than 2 years' => 1
  }.freeze

  # Consmetic constants class
  PART_TYPES = {
    'Hair' => 0,
    'Face' => 1,
    'Body' => 2,
    'Intim' => 3,
    'Hand' => 4,
    'Leg'  => 5
  }.freeze
  SKIN_TYPES = {
    'Dry'     =>  0,
    'Normal'  =>  1,
    'Oily'    =>  2,
    'Comby'   =>  3
  }.freeze

  CONDITIONS = {
    'Colored'     =>  0,
    'Damaged'     =>  1,
    'Waved'       =>  2,
    'Seborea'     =>  3,
    'Akne'        =>  4,
    'Loss'        =>  5,
    'Grow'        =>  6,
    'Dehydrated'  =>  7,
    'Sensitive'   =>  8,
    'Problem'     =>  9,
    'Fading'      =>  10
  }.freeze

  # BOOLEAN_TYPES Consmetic
  HYPOALLERGENIC = { 'NO' => 0, 'YES' => 1 }.freeze
  PERIODIC = {  'NO' => 0, 'YES' => 1 }.freeze

  RUSSIAN_SIZES = {
    '35' => 0,
    '36' => 1,
    '37' => 2,
    '38' => 3,
    '39' => 4,
    '40' => 5,
    '41' => 6,
    '42' => 7,
    '43' => 8,
    '44' => 9,
    '45' => 10,
    '46' => 11,
    '47' => 12,
    '49' => 13,
    '50' => 14,
    '51' => 15,
    '52' => 16,
    '53' => 17,
    '54' => 18,
    '55' => 19
  }.freeze

  EURO_SIZES = {
    '36' => 0,
    '37' => 1,
    '38' => 2,
    '39' => 3,
    '40' => 4,
    '41' => 5,
    '42' => 6,
    '43' => 7,
    '44' => 8,
    '46' => 9,
    '48' => 10,
    '50' => 11,
    '52' => 12,
    '54' => 13,
    '56' => 14,
    '58' => 15
  }.freeze

  EURO_SIZES_PREFIXED = {
    'e36' => 0,
    'e37' => 1,
    'e38' => 2,
    'e39' => 3,
    'e40' => 4,
    'e41' => 5,
    'e42' => 6,
    'e43' => 7,
    'e44' => 8,
    'e46' => 9,
    'e48' => 10,
    'e50' => 11,
    'e52' => 12,
    'e54' => 13,
    'e56' => 14,
    'e58' => 15
  }.freeze

  AMERICAN_SIZES = {
    XS: 0,
    S:  1,
    M:  2,
    L:  3,
    XL: 4,
    XXL: 5,
    XXXL: 6
  }.freeze

  BRITISH_SIZES = {
    '3'   => 0,
    '4'   => 1,
    '5'   => 2,
    '5.5' => 3,
    '6'   => 4,
    '6.5' => 5,
    '7'   => 6,
    '7.5' => 7,
    '8'   => 8,
    '9'   => 9,
    '9.5' => 10
  }.freeze

  BRITISH_SIZES_PREFIXED = {
    'b3'   => 0,
    'b4'   => 1,
    'b5'   => 2,
    'b5.5' => 3,
    'b6'   => 4,
    'b6.5' => 5,
    'b7'   => 6,
    'b7.5' => 7,
    'b8'   => 8,
    'b9'   => 9,
    'b9.5' => 10
  }.freeze

  ASIAN_SIZES = {
    '35' => 0,
    '36' => 1,
    '37' => 2,
    '38' => 3,
    '39' => 4,
    '40' => 5,
    '41' => 6,
    '42' => 7,
    '43' => 8,
    '44' => 9,
    '45' => 10,
    '46' => 11,
    '47' => 12,
    '48' => 13,
    '49' => 14,
    '50' => 15,
    '51' => 16,
    '52' => 17,
    '53' => 18,
    '54' => 19,
    '55' => 20
  }.freeze

  HIGHT_SIZES = {
    'h80-94'    => 0,
    'h95-105'   => 1,
    'h105-115'  => 2,
    'h115-125'  => 3,
    'h125-135'  => 4
  }.freeze
end
