import 'package:flutter/material.dart';

class InitialPage extends StatefulWidget {
	const InitialPage({Key? key}) : super(key: key);

	@override
	State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> with SingleTickerProviderStateMixin {
	late AnimationController _controller;
	late Animation<double> _animation;

	@override
	void initState() {
		super.initState();
		_controller = AnimationController(
			duration: const Duration(seconds: 2),
			vsync: this,
		);
		_animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
		_controller.forward();

		// Redireciona para a Home após a animação
				Future.delayed(const Duration(seconds: 2), () {
					Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
				});
	}

	@override
	void dispose() {
		_controller.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Theme.of(context).primaryColor,
			body: Center(
				child: ScaleTransition(
					scale: _animation,
					child: Column(
						mainAxisSize: MainAxisSize.min,
						children: [
							Icon(Icons.location_on, size: 80, color: Colors.white),
							const SizedBox(height: 16),
							Text(
								'FastLocation',
								style: TextStyle(
									color: Colors.white,
									fontSize: 32,
									fontWeight: FontWeight.bold,
									letterSpacing: 2,
								),
							),
						],
					),
				),
			),
		);
	}
}
