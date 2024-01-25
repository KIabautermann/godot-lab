using Godot;
using System;

public partial class Trail : Line2D
{
	Queue<Vector2> queue = new();
	public override void _Ready()
	{
	}

	
	public override void _Process(double delta)
	{
		Vector2 pos = parent.GlobalPosition + offset;
		queue.Enqueue(pos);
		
		if(queue.Count > MAX_LENGTH)
		{
			queue.Dequeue();
		}
		
		ClearPoint();
		
		foreach (Vector2 point in queue)
		{
			AddPoint(parent.ToLocal(point));
		}
	}
	
	
}
