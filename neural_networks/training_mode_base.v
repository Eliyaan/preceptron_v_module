module neural_networks

// An epoch is when the nn has seen the entire dataset
interface TrainingMode {
	learning_rate   f64
	nb_epochs       int
	cost_function   CostFunctions
	training        Dataset
	test 			Dataset
	test_params 	TestParams
}

pub struct Dataset {
pub mut:
	inputs  [][]f64
	expected_outputs [][]f64
}

// [ start -> end ]
// test_interval in epochs
pub struct TestParams { 
	print_start int
	print_end 	int
	training_interval 	int
	training_batch_interval 	int
}

pub fn (mut nn NeuralNetwork) test(t_m TrainingMode) {
	println("\nTest Dataset:")
	cost_fn, _ := get_cost_function(t_m.cost_function)
	mut error := 0.0
	for i, input in t_m.test.inputs {
		output := nn.forward_propagation(input)
		error += cost_fn(t_m.test.expected_outputs[i], output)
		if i >= t_m.test_params.print_start && i <= t_m.test_params.print_end {
			println("$i -> $output / ${t_m.test.expected_outputs[i]}")
		}
	}
	println('Test Cost : ${error/t_m.training.inputs.len}\n')
	
}