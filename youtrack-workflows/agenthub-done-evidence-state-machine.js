// AH-785 AgentHub Done Evidence Tuple guard source.
// Reject Done/Closed/Owner-Closed unless required evidence fields are present.
exports.rule = {
  title: 'AgentHub Done Evidence Tuple guard',
  guard: function(ctx) {
    var issue = ctx.issue;
    var target = issue.fields.Stage && issue.fields.Stage.name;
    if (target !== 'Done' && target !== 'Closed' && target !== 'Owner-Closed') return true;
    var required = ['implementation_proof_url_or_path','validation_proof_url_or_path','receipt_url_or_path','run_id','source_task','redteam_done_gate','task_readback_ok','register_coverage_ok'];
    required.forEach(function(name) {
      var value = issue.fields[name];
      workflow.check(value && String(value).trim() !== '', 'Done blocked: missing Done Evidence Tuple field ' + name);
    });
    workflow.check(issue.fields.blocker_type === 'NONE', 'Done blocked: blocker_type must be NONE');
    workflow.check(issue.fields.redteam_done_gate === 'PASS', 'Done blocked: redteam_done_gate must be PASS');
    workflow.check(issue.fields.task_readback_ok === true, 'Done blocked: task_readback_ok must be true');
    workflow.check(issue.fields.register_coverage_ok === true, 'Done blocked: register_coverage_ok must be true');
    workflow.check(issue.fields.child_tasks_done === true, 'Done blocked: child tasks are not Done');
    if (target === 'Owner-Closed') workflow.check(issue.fields.owner_exact_close_command === true, 'Owner-Closed blocked without exact owner command');
    return true;
  },
  requirements: {}
};
