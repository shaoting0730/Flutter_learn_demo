import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'particle_controller.dart';
import 'render_particle_field.dart';

class ParticleField extends LeafRenderObjectWidget {
  final ParticleController controller;

  const ParticleField({super.key, required this.controller});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderParticleField(controller: controller);
  }

  @override
  void updateRenderObject(BuildContext context, RenderParticleField renderObject) {
    renderObject.controller = controller;
  }
}
