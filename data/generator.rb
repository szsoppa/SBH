$nucleotids = ['A','C','T','G']
$errno = [1,1,1,1,2,2,2,3]
$rand1_spe = [2,3]
$rand2_spe = [4,5]
$rand3_spe = [4,5]

$rand1_seq = [1, 1, 1, 3, 3, 5]
$rand2_seq = [1, 1, 1, 2, 2, 3, 3, 4, 5]
$rand3_seq = [4, 5]




l = ARGV[0].to_s.to_i # dlugosc nukleotydu w spektrum
p_errors = ARGV[1].to_s.to_i # liczba bledow pozytywnych
n_errors = ARGV[2].to_s.to_i # liczba bledow negatywnych

def get_oligo(l, used_nucleotids)
  oligo = ''
  while true do
    l.times { oligo << $nucleotids.sample }
    used_nucleotids.include?(oligo) ? oligo='' : break
  end
  oligo
end

def prepare_errors(used_nucleotids, l, errors)
  count = errors
  repeats = {}
  while true do
    repeats = {}
    count = errors
    while count != 0 do
      oligo = get_oligo(l, used_nucleotids)
      random = $errno.sample
      next if count - random < 0
      repeats[oligo] = random
      count -= random
    end
    next if repeats.count > errors/2
    break
  end
  repeats
end

def add_to_spectrum_positives(sequence, positive_errors)
  spectrum = []
  repeats = Hash.new(0)
  sequence.each do |x|
    repeats[x] += 1
  end
  repeats.each do |key, value|
    value.times { spectrum << key }
    positive_errors[key].times { spectrum << key }
  end
  spectrum
end

def add_to_sequence_positives(positive_errors)
  sequence = []
  positive_errors.each do |key, value|
    if value == 1
      $rand1_seq.sample.times {sequence << key}
    elsif value == 2
      $rand2_seq.sample.times {sequence << key}
    elsif value == 3
      $rand3_seq.sample.times {sequence << key}
    end
  end
  sequence
end

def add_to_spectrum_negatives(negative_errors)
  spectrum = []
  negative_errors.each do |key, value|
    if value == 1
      $rand1_seq.sample.times {spectrum << key}
    elsif value == 2
      $rand2_seq.sample.times {spectrum << key}
    elsif value == 3
      $rand3_seq.sample.times {spectrum << key}
    end
  end
  spectrum
end

def add_to_sequence_negatives(spectrum, negative_errors)
  sequence = []
  repeats = Hash.new(0)
  spectrum.each do |x|
    repeats[x] += 1
  end
  repeats.each do |key, value|
    value.times { sequence << key }
    negative_errors[key].times { sequence << key }
  end
  sequence
end

def generate_sequence(sequence, spectrum)
  l = sequence[0].length
  for i in (0..sequence.length-1) do
    next if i==0
    cut = rand(1..l-1)
    first = sequence[i-1][l-cut..-1]
    second = sequence[i][0..l-cut-1]
    spectrum << first+second
  end
  spectrum
end


spectrum = []
sequence = []
used_nucleotids = []
positive_errors = []
negative_errors = []
positive_errors = prepare_errors(used_nucleotids, l, p_errors)
used_nucleotids += positive_errors.collect {|key,val| key}
negative_errors = prepare_errors(used_nucleotids, l, n_errors)
positives_sequence = add_to_sequence_positives(positive_errors)
positives_spectrum = add_to_spectrum_positives(positives_sequence, positive_errors)
negatives_spectrum = add_to_spectrum_negatives(negative_errors)
negatives_sequence = add_to_sequence_negatives(negatives_spectrum, negative_errors)

sequence = negatives_sequence + positives_sequence
spectrum = positives_spectrum + negatives_spectrum
sequence.shuffle!
spectrum = generate_sequence(sequence, spectrum)
spectrum.shuffle!

sequence = sequence.join('')
file = File.open('./sequence/'+sequence.length.to_s, 'w+')
file.write sequence
file.close
file = File.open('./spectrum/'+spectrum.size.to_s, 'w+')
file.write spectrum.join("\n")
file.close
puts spectrum.size
puts sequence.length
