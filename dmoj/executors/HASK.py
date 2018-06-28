from dmoj.executors.base_executor import CompiledExecutor
from dmoj.executors.mixins import NullStdoutMixin


class Executor(NullStdoutMixin, CompiledExecutor):
    ext = '.hs'
    name = 'HASK'
    command = 'ghc'
    syscalls = ['newselect', 'select', 'poll']
    test_program = 'main = interact id'

    def get_compile_args(self):
        return [self.get_command(), '-O', '-o', self.problem, self._code]
